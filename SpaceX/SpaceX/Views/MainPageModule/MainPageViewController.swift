//
//  MainPageViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import UIKit
import SnapKit

protocol MainPageViewProtocol: AnyObject {
    var pages: [UIViewController] {get set}
    func successUpload()
    func failure(error: NetworkError)
    func isShowLoadingView(_ isShow: Bool)
}

class MainPageViewController: UIPageViewController {
    
    // MARK: - Private properties
    
    private lazy var loadingView = LoadingView()

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
    
    // MARK: - Public properties
    
    var pages: [UIViewController] = []
    var presenter: MainPagePresenterProtocol?
    var currentPage = 0
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    // MARK: - Private Methods
        
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
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Objc Methods
    
    @objc private func swipePageControl(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]],
                           direction: .forward,
                           animated: true)
    }
}

// MARK: - MainPageViewProtocol

extension MainPageViewController: MainPageViewProtocol {
    func successUpload() {
        presenter?.setPages()
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = pages.count
        setViewControllers([pages[self.currentPage]],
                           direction: .forward,
                           animated: true)
    }
    
    func failure(error: NetworkError) {
        let message = "\(error.localizedDescription) \nRestart"
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: (restart))
        let alertLogOut = UIAlertController(title: "Oops!",
                                            message: message,
                                            preferredStyle: .alert)
        alertLogOut.addAction(action)
        present(alertLogOut, animated: true)
        print(error)
    }
    
    func restart(action: UIAlertAction) {
        presenter?.fetchRockets()
    }
    
    func isShowLoadingView(_ isShow: Bool) {
        if isShow == true {
            loadingView.isHidden = false
        } else if isShow == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1),
                                          execute: { () -> Void in
                self.loadingView.isHidden = true
            })
        }
    }
}

// MARK: - UIPageViewControllerDataSource

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


