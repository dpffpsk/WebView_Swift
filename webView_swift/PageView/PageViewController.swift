//
//  PageViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/11.
//

import UIKit

class PageViewController: BaseViewController {
    
    var currentPage = 0

    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return vc
    }()
    
    let vc1 = PageWebViewController(url: "https://www.naver.com")
    let vc2 = PageWebViewController(url: "https://www.google.com")
    let vc3 = PageWebViewController(url: "https://www.daum.net")
    
    lazy var dataViewController: [UIViewController] = {
       return [vc1, vc2, vc3]
    }()
    
    lazy var prevButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("< prev", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(prevAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("next >", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var barBackButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapToolBarBackButton))
    }()

    lazy var barForwardButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: self, action: #selector(didTapToolBarForwardButton))
    }()
    

    // history back
    @objc func didTapToolBarBackButton() {
        guard let vc = pageViewController.viewControllers?.first as? PageWebViewController else { return }
        
        if vc == vc1 {
            if vc.webView.canGoBack {
                vc.webView.goBack()
                return
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    // history forward
    @objc func didTapToolBarForwardButton() {
        guard let vc = pageViewController.viewControllers?.first as? PageWebViewController else { return }
        
        if vc == vc1 {
            if vc.webView.canGoForward {
                vc.webView.goForward()
                return
            }
        }
    }
    
    func addBottomToolBar() {
        let paddingButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        paddingButtonItem.width = 24.0
        toolbarItems = [barBackButtonItem, paddingButtonItem, barForwardButtonItem]
        navigationController?.isToolbarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBottomToolBar()
        setPageView()
    }
    
    override func setupLayout() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(prevButton)
        view.addSubview(nextButton)
        pageViewController.didMove(toParent: self)
    }
    
    override func setupConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.leadingAnchor.constraint(equalTo: self.pageViewController.view.leadingAnchor).isActive = true
        prevButton.centerYAnchor.constraint(equalTo: self.pageViewController.view.centerYAnchor).isActive = true
        prevButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        prevButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: self.pageViewController.view.trailingAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: self.pageViewController.view.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setPageView() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        if let firstVC = dataViewController.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        prevButton.isHidden = true
    }
    
    // prevButton
    @objc func prevAction(_ sender: Any) {
        // 지금 페이지 - 1
        let prevPage = currentPage - 1
        if prevPage < 0 { return }
        
        //화면 이동 (지금 페이지에서 -1 페이지로 setView 합니다.)
        pageViewController.setViewControllers([dataViewController[prevPage]], direction: .reverse, animated: true)
        
        currentPage = prevPage
        enabledBtn()
    }
    
    // nextButton
    @objc func nextAction(_ sender: Any) {
        // 지금 페이지 + 1
        let nextPage = currentPage + 1
        if nextPage == dataViewController.count { return }
        
        //화면 이동 (지금 페이지에서 -1 페이지로 setView 합니다.)
        pageViewController.setViewControllers([dataViewController[nextPage]], direction: .forward, animated: true)
        
        //현재 페이지 잡아주기
        currentPage = nextPage
        enabledBtn()
    }
    
    func enabledBtn() {
        switch currentPage {
        case 0: // 첫번째 페이지
            prevButton.isHidden = true
        case dataViewController.count-1: // 마지막 페이지
            nextButton.isHidden = true
        default:
            prevButton.isHidden = false
            nextButton.isHidden = false
        }
    }
}

// 페이징 제스처 이용시 DataSource 필요!
extension PageViewController: UIPageViewControllerDataSource {
    // 이전 페이지 이동
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewController.firstIndex(of: viewController) else { return nil }

        let previousIndex = index - 1
        if previousIndex < 0 { return nil }

        return dataViewController[previousIndex]
    }
    
    // 다음 페이지 이동
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewController.firstIndex(of: viewController) else { return nil }

        let nextIndex = index + 1
        if nextIndex == dataViewController.count { return nil }

        return dataViewController[nextIndex]
    }
}

// 페이징 이벤트 시작 or 끝났을 때 이벤트 추가시 Delegate 필요!
extension PageViewController: UIPageViewControllerDelegate {
    // 현재 페이지
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed,
          let currentVC = pageViewController.viewControllers?.first,
          let index = dataViewController.firstIndex(of: currentVC) else { return }
        
        currentPage = index
        enabledBtn()
    }
}
