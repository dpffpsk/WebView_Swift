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
    
    lazy var vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        return vc
    }()
    
    lazy var vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    
    lazy var vc3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()
    
    lazy var dataViewController: [UIViewController] = {
       return [vc1, vc2, vc3]
    }()
    
    lazy var preButton: UIButton = {
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
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageView()
    }
    
    override func setupLayout() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(preButton)
        view.addSubview(nextButton)
        pageViewController.didMove(toParent: self)
    }
    
    override func setupConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        preButton.translatesAutoresizingMaskIntoConstraints = false
        preButton.leadingAnchor.constraint(equalTo: self.pageViewController.view.leadingAnchor).isActive = true
        preButton.centerYAnchor.constraint(equalTo: self.pageViewController.view.centerYAnchor).isActive = true
        preButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        preButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setPageView() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        if let firstVC = dataViewController.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        // pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        // let mainView = UIView()
        // 메인뷰와 크기를 같게할 경우
        // pageViewController.view.frame = mainView.frame
    }
    
    @objc func prevAction(_ sender: Any) {
        // 지금 페이지 - 1
        let prevPage = currentPage - 1
        //화면 이동 (지금 페이지에서 -1 페이지로 setView 합니다.)
        pageViewController.setViewControllers([dataViewController[prevPage]], direction: .reverse, animated: true)
        
        //현재 페이지 잡아주기
        currentPage = pageViewController.viewControllers!.first!.view.tag
    }
}

// 페이징 제스처 이용시 DataSource 필요!
extension PageViewController: UIPageViewControllerDataSource {
    // 이전 페이지 이동
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewController.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewController[previousIndex]
    }
    
    // 다음 페이지 이동
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewController.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewController.count {
            return nil
        }
        return dataViewController[nextIndex]
    }
}


// 페이징 이벤트 시작 or 끝났을 때 이벤트 추가시 Delegate 필요!
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        print("======: \(pageViewController.viewControllers!.first!.view.tag)")
        currentPage = 1
    }
}
