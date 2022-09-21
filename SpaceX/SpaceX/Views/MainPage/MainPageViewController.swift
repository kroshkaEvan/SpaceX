//
//  MainPageViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import UIKit
import SnapKit

protocol MainPageViewProtocol: AnyObject {
    func success(withNumber number: Int)
    func isShowLoadingView(_ isShow: Bool)
}

class MainPageViewController: UIPageViewController {
    
    private lazy var pages: [UIViewController] = []
    private lazy var assemblyBuilder = AssemblyBuilder()
    private lazy var loadingView = LoadingView()

    var presenter: MainPagePresenterProtocol?
    var currentPage = 0

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        pageControl.addTarget(self,
                              action: #selector(swipePageControl),
                              for: .valueChanged)
        return pageControl
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
        
    private func setupView() {
        dataSource = self
        delegate = self
    }
    
    private func setupLayout() {
        [pageControl, loadingView].forEach { view.addSubview($0) }
        pageControl.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func swipePageControl(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]],
                           direction: .forward,
                           animated: true)
    }
}

extension MainPageViewController: MainPageViewProtocol {
    func success(withNumber number: Int) {
        let router = Router(navigationController: UINavigationController(),
                            assemblyBuilder: assemblyBuilder)
        guard let rockets = presenter?.rockets?.count else { return }
        
        for serialNumber in 0..<rockets {
            let viewController = assemblyBuilder.setRocketModule(router: router,
                                                                 with: serialNumber)
            pages.append(viewController)
        }
        
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = pages.count
        
        setViewControllers([pages[self.currentPage]],
                           direction: .forward,
                           animated: true)
    }
    
    func isShowLoadingView(_ isShow: Bool) {
        if isShow == true {
            loadingView.isHidden = false
        } else if isShow == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2),
                                          execute: { () -> Void in
                self.loadingView.isHidden = true
            })
        }
    }
}

extension MainPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
    }
}


