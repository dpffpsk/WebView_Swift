//
//  ContactPermission.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/11/01.
//

import Foundation

class ContactPermission {
    /*
     let status = CNContactStore.authorizationStatus(for: .contacts)
     let vc = CNContactPickerViewController()
     vc.delegate = self
     switch status {
     case .authorized:
         present(vc, animated: true, completion: nil)
     default:
         CNContactStore().requestAccess(for: .contacts) { [weak self] success, error in
             guard let self = self else { return }
             if success {
                 DispatchQueue.main.async {
                     self.present(vc, animated: true, completion: nil)
                 }
             } else {
                 guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                 if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 }
             }
         }
     }
     */

}
