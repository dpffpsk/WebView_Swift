//
//  EncryptionViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/22.
//

import UIKit
import CryptoSwift

class AES256 {
    /*
     * AES 128 [key] : 16 byte
     * AES 192 [key] : 24 byte
     * AES 256 [key] : 32 byte
     */
    private static let SECRET_KEY = "0123456789abcdef0123456789abcdef"
    private static let IV = "0123456789abcdef"
//    private static let IV = ""
    
    
    static func encrypt(string: String) -> String {
        guard !string.isEmpty else { return "" }
        return try! getAESObject().encrypt(string.bytes).toBase64()
    }
    
    static func decrypt(encoded: String) -> String {
        let datas = Data(base64Encoded: encoded)
        
        guard datas != nil else {
            return ""
        }
        
        let bytes = datas!.bytes
        let decode = try! self.getAESObject().decrypt(bytes)
        return String(bytes: decode, encoding: .utf8) ?? ""
    }
    
    static func getAESObject() -> AES {
        let keyDecodes: Array<UInt8> = Array(SECRET_KEY.utf8)
        let ivDecodes: Array<UInt8> = Array(IV.utf8)
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)

        /*
        var ivDecodes : Array<UInt8> = []
        if IV != "" || IV.count > 0 {
            ivDecodes = Array(IV.utf8)
        }
        else {
            ivDecodes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
         */
        
        return aesObject
    }
}

class EncryptionViewController: BaseViewController {

    let encryptionView = EncryptionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        encryptionView.encryptTextField.delegate = self
        encryptionView.decryptTextField.delegate = self
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(encryptionView)
    }
    
    override func setupConstraints() {
        encryptionView.translatesAutoresizingMaskIntoConstraints = false
        encryptionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        encryptionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        encryptionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        encryptionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func buttonAction() {
        self.encryptionView.encryptButton.addTarget(self, action: #selector(encrypt), for: .touchUpInside)
        self.encryptionView.decryptButton.addTarget(self, action: #selector(decrypt), for: .touchUpInside)
    }
    
    @objc func encrypt(_: UIButton) {
        view.endEditing(true)
        if let text = encryptionView.encryptTextField.text {
//            encryptionView.encryptLabel.text = AES256.encrypt(string: text)
            encryptionView.decryptTextField.text = AES256.encrypt(string: text)
        }
    }
    
    @objc func decrypt(_: UIButton) {
        view.endEditing(true)
        if let text = encryptionView.decryptTextField.text {

            encryptionView.decryptLabel.text = AES256.decrypt(encoded: text)
        }
    }
}

// textField 글자수 제한
extension EncryptionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 10
    }
}
