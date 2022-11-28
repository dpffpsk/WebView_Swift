//
//  LocalizationViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/24.
//

import UIKit

class LocalizationViewController: BaseViewController {

    let localizationView = LocalizationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLanguage()
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(localizationView)
    }
    
    override func setupConstraints() {
        localizationView.translatesAutoresizingMaskIntoConstraints = false
        localizationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        localizationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        localizationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        localizationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func buttonAction() {
        self.localizationView.koreanButton.addTarget(self, action: #selector(changedKorean), for: .touchUpInside)
        self.localizationView.englishButton.addTarget(self, action: #selector(changedEnglish), for: .touchUpInside)
    }
    
    @objc func changedKorean(_: UIButton) {
        // 한국어로 변경
        UserDefaults.standard.set("ko", forKey: "Localization")
        UserDefaults.standard.synchronize()
        
        setLanguage()
    }
    
    @objc func changedEnglish(_: UIButton) {
        // 영어로 변경
        UserDefaults.standard.set("en", forKey: "Localization")
        UserDefaults.standard.synchronize()
        
        setLanguage()
    }
    
    func setLanguage() {
        //설정된 언어 코드 가져오기
        let language = UserDefaults.standard.string(forKey: "Localization")
        
        //설정된 언어 파일 가져오기
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        self.localizationView.textLabel1.text = bundle?.localizedString(forKey: "Hello", value: nil, table: nil)
        self.localizationView.textLabel2.text = bundle?.localizedString(forKey: "Welcome", value: nil, table: nil)
        self.localizationView.textLabel3.text = bundle?.localizedString(forKey: "Thank", value: nil, table: nil)
    }
}

