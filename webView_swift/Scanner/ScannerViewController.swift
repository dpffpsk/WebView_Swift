//
//  ReaderViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/07.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {

    // 카메라 화면을 보여줄 Layer
    var previewLayer: AVCaptureVideoPreviewLayer?
    let captureSession = AVCaptureSession()
    
    private var cornerLength: CGFloat = 20
    private var cornerLineWidth: CGFloat = 6
    private var rectOfInterest: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectOfInterest = CGRect(x: (self.view.bounds.width / 2) - (200 / 2),
                                y: (self.view.bounds.height / 2) - (200 / 2),
                                width: 200,
                                height: 200)
        initialSetupView()
        setCloseButton()
    }
    
    // AVCaptureSession을 실행하는 화면을 구성 후 실행합니다.
    private func initialSetupView() {
        self.view.clipsToBounds = true
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        // captureDevice에서 영상으로 촬영을 하면 지속적으로 데이터를 넣어주고, 그것을 위에서 만든 영상을 담고 처리하는 공간인 session에 추가해줍니다.
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
        } catch {
            print("error")
        }
        
        // captureSession에서 우리가 넣어준 input 결과물을 빼주고 이것을 mainThread에서 처리 해줍니다.
        // 그리고 이 결과물을 QR 코드로 인식 하게 됩니다.
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.upce,
                                      .code39,
                                      .code39Mod43,
                                      .code93,
                                      .code128,
                                      .ean8,
                                      .ean13,
                                      .aztec,
                                      .pdf417,
                                      .itf14,
                                      .dataMatrix,
                                      .interleaved2of5,
                                      .qr
                                    ]
        
        self.setPreviewLayer()
        self.setFocusZoneCornerLayer()
        
        DispatchQueue.global().async {
            self.captureSession.startRunning() // must be used from background
            
            // QRCode 인식 범위 설정하기
            // output.rectOfInterest 는 AVCaptureSession에서 CGRect 크기만큼 인식 구역으로 지정합니다.
            // !! 단 해당 값은 먼저 AVCaptureSession를 running 상태로 만든 후 지정해주어야 정상적으로 작동합니다 !!
            output.rectOfInterest = self.previewLayer!.metadataOutputRectConverted(fromLayerRect: self.rectOfInterest!)
        }
    }
    
    // 중앙에 사각형의 Focus Zone Layer을 설정합니다.
    private func setPreviewLayer() {
        let readingRect = rectOfInterest

        // AVCaptureVideoPreviewLayer를 구성.
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.view.layer.bounds

        // MARK: - Scan Focus Mask
        // - Scan 할 사각형(Focus Zone)을 구성하고 해당 자리만 dimmed 처리를 하지 않음.
        // - CAShapeLayer에서 어떠한 모양(다각형, 폴리곤 등의 도형)을 그리고자 할 때 CGPath를 사용한다.
        // - 즉 previewLayer에다가 ShapeLayer를 그리는데
        // - ShapeLayer의 모양이 [1. bounds 크기의 사각형, 2. readingRect 크기의 사각형]
        // - 두개가 그려져 있는 것이다.
        let path = CGMutablePath()
        path.addRect(self.view.bounds)
        path.addRect(readingRect!)

        // - 그럼 Path(경로? 모양?)은 그렸으니 Layer의 특징을 정하고 추가해보자.
        // - 먼저 CAShapeLayer의 path를 위에 지정한 path로 설정해주고,
        // - QRReader에서 백그라운드 색이 dimmed 처리가 되어야 하므로 layer의 투명도를 0.6 정도로 설정한다.
        // - 단 여기서 QRCode를 읽을 부분은 dimmed 처리가 되어 있으면 안 된다.
        // - 이럴때 fillRule에서 evenOdd를 지정해주는데
        // - Path(도형)이 겹치는 부분(여기서는 readingRect, QRCode 읽는 부분)은 fillColor의 영향을 받지 않는다
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        maskLayer.fillColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        maskLayer.fillRule = .evenOdd

        previewLayer.addSublayer(maskLayer)

        self.view.layer.addSublayer(previewLayer)
        self.previewLayer = previewLayer
    }
    
    // MARK: - Focus Edge Layer
    // Focus Zone의 모서리에 테두리 Layer을 씌웁니다.
    private func setFocusZoneCornerLayer() {
        var cornerRadius = previewLayer?.cornerRadius ?? CALayer().cornerRadius
        if cornerRadius > cornerLength { cornerRadius = cornerLength }
        if cornerLength > rectOfInterest!.width / 2 { cornerLength = rectOfInterest!.width / 2 }

        // Focus Zone의 각 모서리 point
        let upperLeftPoint = CGPoint(x: rectOfInterest!.minX - cornerLineWidth / 2, y: rectOfInterest!.minY - cornerLineWidth / 2)
        let upperRightPoint = CGPoint(x: rectOfInterest!.maxX + cornerLineWidth / 2, y: rectOfInterest!.minY - cornerLineWidth / 2)
        let lowerRightPoint = CGPoint(x: rectOfInterest!.maxX + cornerLineWidth / 2, y: rectOfInterest!.maxY + cornerLineWidth / 2)
        let lowerLeftPoint = CGPoint(x: rectOfInterest!.minX - cornerLineWidth / 2, y: rectOfInterest!.maxY + cornerLineWidth / 2)
        
        // 각 모서리를 중심으로 한 Edge를 그림.
        let upperLeftCorner = UIBezierPath()
        upperLeftCorner.move(to: upperLeftPoint.offsetBy(dx: 0, dy: cornerLength))
        upperLeftCorner.addArc(withCenter: upperLeftPoint.offsetBy(dx: cornerRadius, dy: cornerRadius), radius: cornerRadius, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true)
        upperLeftCorner.addLine(to: upperLeftPoint.offsetBy(dx: cornerLength, dy: 0))

        let upperRightCorner = UIBezierPath()
        upperRightCorner.move(to: upperRightPoint.offsetBy(dx: -cornerLength, dy: 0))
        upperRightCorner.addArc(withCenter: upperRightPoint.offsetBy(dx: -cornerRadius, dy: cornerRadius),
                              radius: cornerRadius, startAngle: 3 * .pi / 2, endAngle: 0, clockwise: true)
        upperRightCorner.addLine(to: upperRightPoint.offsetBy(dx: 0, dy: cornerLength))

        let lowerRightCorner = UIBezierPath()
        lowerRightCorner.move(to: lowerRightPoint.offsetBy(dx: 0, dy: -cornerLength))
        lowerRightCorner.addArc(withCenter: lowerRightPoint.offsetBy(dx: -cornerRadius, dy: -cornerRadius),
                                 radius: cornerRadius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        lowerRightCorner.addLine(to: lowerRightPoint.offsetBy(dx: -cornerLength, dy: 0))

        let bottomLeftCorner = UIBezierPath()
        bottomLeftCorner.move(to: lowerLeftPoint.offsetBy(dx: cornerLength, dy: 0))
        bottomLeftCorner.addArc(withCenter: lowerLeftPoint.offsetBy(dx: cornerRadius, dy: -cornerRadius),
                                radius: cornerRadius, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        bottomLeftCorner.addLine(to: lowerLeftPoint.offsetBy(dx: 0, dy: -cornerLength))
        
        // 그려진 UIBezierPath를 묶어서 CAShapeLayer에 path를 추가 후 화면에 추가.
        let combinedPath = CGMutablePath()
        combinedPath.addPath(upperLeftCorner.cgPath)
        combinedPath.addPath(upperRightCorner.cgPath)
        combinedPath.addPath(lowerRightCorner.cgPath)
        combinedPath.addPath(bottomLeftCorner.cgPath)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = combinedPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = cornerLineWidth
        shapeLayer.lineCap = .square

        self.previewLayer!.addSublayer(shapeLayer)
    }
    
    private func setCloseButton() {
        let closeButton: UIButton = {
            let btn = UIButton()
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
            btn.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: largeConfig), for: .normal)
            btn.tintColor = .white
            btn.frame = CGRectMake(200, 10, 300, 50) // x,y,너비,높이
            btn.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
            return btn
        }()
        
        view.addSubview(closeButton)
    }
    
    @objc func close(_ button: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    // QR을 인식하면 코드 실행
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 { return }
        
        // metadataObjects는 인식한 사물의 수
        // 첫번째 인식한 객체만 사용
        guard let metaObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
//        guard let metaObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
        
        /*
            if metaObject.type == AVMetadataObject.ObjectType.qr {
                if let outputValue = metaObject.stringValue {
                    if outputValue.hasPrefix("http://") || outputValue.hasPrefix("https://") {
                    }
                }
            }
         */
        if let outputValue = metaObject.stringValue {
            let alert = UIAlertController(title: "Scanner", message: "TYPE : \(metaObject.type)\nVALUE : \(outputValue)", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(ok)

            DispatchQueue.main.async {
                UIApplication.topViewController()?.present(alert, animated: true)
                
                print(outputValue)
            }
            
            // 진동
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            // 카메라 인식 종료
            captureSession.stopRunning()
        }
    }
}
