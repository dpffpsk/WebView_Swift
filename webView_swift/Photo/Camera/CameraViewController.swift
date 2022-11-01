//
//  CameraViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/27.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: BaseViewController {

    let cameraView = CameraView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cameraPermission()
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(cameraView)
    }
    
    override func setupConstraints() {
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cameraView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cameraView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cameraView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // 카메라 권한
    private func cameraPermission() {
        print("-------")
        var c: Camera!
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) in
            if granted {

                    c = Camera(self!)
                    c.open()

//                self?.openCamera()
            } else {
                self?.deniedPermission("카메라", "카메라")
            }
        })
    }
    
    // 사진 저장 alert
    private func savedImageAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "사진이 저장되었습니다.", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        print("")
        print("===============================")
        print("사진 : 권한 허용")
        print("===============================")
        print("")
    }
    
    // 권한 거부 alert
    private func deniedPermission(_ str1: String, _ str2: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "\(str1)을 사용할 수 없습니다.\n설정 > 개인정보 보호 > \(str2) > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "설정", style: .default, handler: { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            })
            let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            alert.addAction(cancel)
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        print("")
        print("===============================")
        print("\(str1) : 권한 거부")
        print("===============================")
        print("")
    }
    
    // 카메라 노출
    private func openCamera() {
        DispatchQueue.main.async {
            let pickerController = UIImagePickerController() // must be used from main thread only
            pickerController.sourceType = .camera
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            
            // video
            // pickerController.mediaTypes = ["public.movie"]
            // pickerController.videoQuality = .typeHigh
            pickerController.delegate = self

            self.present(pickerController, animated: true)
        }
    }
    
    // Retake 버튼
    private func buttonAction() {
        self.cameraView.retakeButton.addTarget(self, action: #selector(retake), for: .touchUpInside)
    }
    
    @objc func retake(_: UIButton) {
        print("retake")
        self.cameraPermission()
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 사진 가져오기
        // guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
        //   picker.dismiss(animated: true)
        //   return
        // }
        // 동영상 가져오기(url로 받는 형태)
        // guard let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
        //   picker.dismiss(animated: true, completion: nil)
        //   return
        // }
        // let video = AVAsset(url: url)
        
        // 이미지뷰에 이미지 넣기
        // self.imageView.image = image
        // 카메라 종료
        // picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage), nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 촬영한 사진 저장
    @objc func savedImage(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        
        // 사진첩 권한
        PHPhotoLibrary.requestAuthorization( { [weak self] status in
            if status == .authorized {
                self?.savedImageAlert()
            } else {
                self?.deniedPermission("사진첩", "사진")
                
                if let error = error {
                    print("UIImageWriteToSavedPhotosAlbum Error : \(error)")
                    return
                }
            }
        })
    }
}

