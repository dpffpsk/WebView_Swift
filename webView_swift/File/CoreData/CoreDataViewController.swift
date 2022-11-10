//
//  CoreDataViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/09.
//

import UIKit
import PhotosUI
import CoreData

class CoreDataViewController: BaseViewController {
    
    let coreDataView = CoreDataView()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(coreDataView)
    }
    
    override func setupConstraints() {
        coreDataView.translatesAutoresizingMaskIntoConstraints = false
        coreDataView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        coreDataView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        coreDataView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        coreDataView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func buttonAction() {
        coreDataView.selectImageButton.addTarget(self, action: #selector(selectButtonAction(_:)), for: .touchUpInside)
        coreDataView.getImageButton.addTarget(self, action: #selector(getButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func selectButtonAction(_: UIButton) {
        GalleryPermission().requestAuthorization { [weak self] _ in
            self?.openGallery()
        }
    }
    
    @objc func getButtonAction(_: UIButton) {
        // 저장된 사진 불러오기
        retrieveData()
    }
    
    // 사진첩 열기
    private func openGallery() {
        // available(iOS 14.0, *)
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])

        DispatchQueue.main.async {
            let picker = PHPickerViewController(configuration: configuration) // must be used from main thread only
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    // CoreData CRUD
    /// Retrieve
    private func retrieveData() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        do {
            let data = try context.fetch(ImageTable.fetchRequest())
            print("Retrieve Data : \(data)")
            
            guard let imageData = data[0].imageData else { return }
            if let uiImage: UIImage = UIImage(data: imageData) {
                coreDataView.getImageView.image = uiImage
            }
        } catch {
            print("Retrieve Error : \(error.localizedDescription)")
        }
    }
    
    // Create
    private func createData(imageData: Data) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        let data = ImageTable(context: context)
        data.imageData = imageData
        
        do {
            try context.save()
        } catch {
            print("Create error : \(error.localizedDescription)")
        }
    }
    
    /// Update
    private func updateData(imageData: Data) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        do {
            let data = try context.fetch(ImageTable.fetchRequest())
            print("Update Data : \(data)")
            data[0].imageData = imageData
            
            try? context.save()
            
        } catch {
            print("Update error : \(error.localizedDescription)")
        }
    }
    
    /// Delete
    private func deleteData() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        do {
            let data = try context.fetch(ImageTable.fetchRequest())
            context.delete(data[0])
            try? context.save()
        } catch {
            print("Delete error : \(error.localizedDescription)")
        }
    }
    
    private func isNull(bool: ((Bool) -> Void)? = nil) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        do {
            let data = try context.fetch(ImageTable.fetchRequest())
            bool?(data.isEmpty)
        } catch {
            print("Retrieve Error : \(error.localizedDescription)")
        }
    }
}

// available(iOS 14.0, *)
extension CoreDataViewController: PHPickerViewControllerDelegate {
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                // 사진데이터 저장
                
                guard let img = image as? UIImage else { return }
                guard let img2 = img.pngData() else { return }

                DispatchQueue.main.async {
                    self.isNull { [weak self] bool in
                        if bool {
                            print("CoreData Create")
                            self?.createData(imageData: img2)
                        } else {
                            print("CoreData Update")
                            self?.updateData(imageData: img2)
                        }
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}

