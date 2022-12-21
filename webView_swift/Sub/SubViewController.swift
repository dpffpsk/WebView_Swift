//
//  SubViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/19.
//

import UIKit

class SubViewController: UIViewController {
    
    let introView = IntroView()
    let subView: SubView = SubView()
    
    let header = ["WebView",
                  "TableView",
                  "Permission",
                  "Photo",
                  "Scanner",
                  "File",
                  "PageView",
                  "Encrypt&Decrypt",
                  "Presentation",
                  "Share",
                  "Localization",
                  "Authorization",
                  "PDF",
                  "Sheet"]
    
    let data = [["WKWebView"],
                ["Basic", "Custom", "Expand"],
                ["권한 설정"],
                ["Camera", "Gallery"],
                ["QR&Barcode Scanner", "QRcode"],
                ["CoreData", "DataBase(SQLite)"],
                ["PageView"],
                ["암,복호화"],
                ["화면 전환 애니메이션"],
                ["공유하기"],
                ["다국어처리"],
                ["생체인증", "패턴", "example"],
                ["PDF"],
                ["SheetView", "SheetPresentation"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        subView.tableView.dataSource = self
        subView.tableView.delegate = self
        
        setupLayout()
        setupConstraints()
        setIntro()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    func setupLayout() {
        view.addSubview(subView)
        view.addSubview(introView)
    }
    
    func setupConstraints() {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        subView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        subView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        subView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        introView.translatesAutoresizingMaskIntoConstraints = false
        introView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        introView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        introView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        introView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setIntro() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(introTimer), userInfo: nil, repeats: false)
    }
    
    @objc func introTimer() {
        view.subviews.forEach { view in
            if view == introView {
                view.removeFromSuperview()
            }
        }
    }
}

extension SubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        cell.accessoryType = .disclosureIndicator
        
        // 달라진 방식(iOS 14.0 이상)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.data[indexPath.section][indexPath.row]
            cell.contentConfiguration = content
        } else {
        // 기존과 동일(iOS 14.0 까지만 지원)
            cell.textLabel?.text = self.data[indexPath.section][indexPath.row]
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc = UIViewController()

        switch indexPath.section {
        case 0: // WebView
            vc = MainViewController()
        case 1: // TableView
            switch indexPath.row {
            case 0:
                vc = BasicTableViewController()
            case 1:
                vc = CustomTableViewController()
            case 2:
                vc = ExpandableViewController()
            default:
                print("empty vc")
            }
        case 2: // Permission
            vc = PermissionViewController()
        case 3: // Photo
            switch indexPath.row {
            case 0:
                vc = CameraViewController()
            case 1:
                vc = GalleryViewController()
            default:
                print("empty vc")
            }
        case 4: // Scanner
            switch indexPath.row {
            case 0:
                vc = ScannerViewController()
            case 1:
                vc = QRCodeViewController()
            default:
                print("empty vc")
            }
            
            self.present(vc, animated: true)
            return
        case 5: // File
            switch indexPath.row {
            case 0:
                vc = CoreDataViewController()
            case 1:
                vc = DataBaseViewController()
            default:
                print("empty vc")
            }
        case 6: // PageView
            vc = PageViewController()
        case 7: // Ecrypt&Decrypt
            vc = EncryptionViewController()
        case 8: // Presentation
            vc = PresentationViewController()
        case 9: // Share
            vc = ShareViewController()
        case 10: // Localization
            vc = LocalizationViewController()
        case 11: // Authorization
            switch indexPath.row {
            case 0:
                vc = BiometricsViewController()
            case 1:
                vc = PatternLockViewController()
            case 2:
                vc = DragOnLineViewController()
            default:
                print("empty vc")
            }
        case 12: // PDF
            vc = PDFViewController()
        case 13: // Sheet
            switch indexPath.row {
            case 0:
                vc = SheetViewController()
            case 1:
                vc = SheetPresentationViewController()
            default:
                print("empty vc")
            }
        default:
            print("empty section")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
