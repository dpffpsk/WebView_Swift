//
//  Camera.swift
//  webView_swift
//
//  Created by wons on 2022/11/01.
//

import Foundation
import UIKit
import Photos

// TODO: 카메라 불러오기(버튼 동작)
class Camera: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let camera = UIImagePickerController()
    var view: UIViewController!
    
    init(_ view: UIViewController) {
        super.init()
        self.view = view
        self.setCamera()
    }
    
    /*
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
     */
    
    private func setCamera() {
        camera.sourceType = .camera
        camera.allowsEditing = true
        camera.cameraDevice = .rear
        camera.cameraCaptureMode = .photo
        camera.delegate = self
    }
    
    func open() {
        DispatchQueue.main.async {
            self.view?.present(self.self.camera, animated: true, completion: nil)
        }
    }
    
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
        
        print("=========")
        if let image = info[.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage), nil)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // 촬영한 사진 저장
    @objc func savedImage(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        print("savedImage")

        savedImageAlert()
    }
    
    // 사진 저장 alert
    private func savedImageAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "사진이 저장되었습니다.", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            self.view?.present(alert, animated: true)
//            self.present(alert, animated: true, completion: nil)
        }
    }
}
