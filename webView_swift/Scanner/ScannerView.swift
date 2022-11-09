//
//  ScannerView.swift
//  webView_swift
//
//  Created by wons on 2022/11/07.
//

import UIKit
import AVFoundation

// 기본 Scanner(동작 시키려면 VC생성해야 함)
class ScannerView: UIView {
    let session = AVCaptureSession()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        basicSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func basicSetting(){
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch{
            print("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        let video  = AVCaptureVideoPreviewLayer(session: session)
        video.frame = self.layer.bounds
        video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.layer.addSublayer(video)
        
        session.startRunning()
    }
}

extension ScannerView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 { return }
        
        guard let metaObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        
        if metaObject.type == AVMetadataObject.ObjectType.qr {
            if let outPutValue = metaObject.stringValue{
                if outPutValue.hasPrefix("http://") || outPutValue.hasPrefix("https://")  {
                    print("outPutValue : \(outPutValue)")
                    session.stopRunning()
                }
            }
        }
    }
}
