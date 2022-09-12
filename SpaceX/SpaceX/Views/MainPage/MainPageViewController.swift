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
}

class MainPageViewController: UIPageViewController {

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
    }()
      
    private lazy var pages: [UIViewController] = []
    
    var presenter: MainPagePresenterProtocol?
        
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
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainPageViewController: MainPageViewProtocol {
    func success(withNumber number: Int) {
        
    }
}

extension MainPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return pages[1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return pages[1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }
}


