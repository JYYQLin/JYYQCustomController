//
//  JY_Driving_Test_Essentials_Directory_PageController.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Directory_PageController: UIPageViewController {
    
    var yq_page_index_block: ((_ index: Int) -> Void)?
    
    private(set) lazy var yq_current_page_index: Int = 0 {
        didSet {
            if yq_page_index_block != nil {
                yq_page_index_block!(yq_current_page_index)
            }
        }
    }
    
    private lazy var yq_controller_array: [UIViewController] = [UIViewController]()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension JY_Driving_Test_Essentials_Directory_PageController {
    func yq_set(pageIndex: Int) {
                
        guard pageIndex >= 0 && pageIndex < yq_controller_array.count else {
            return
        }
        let targetVC = yq_controller_array[pageIndex]
        if let currentVC = yq_controller_array.first,
           let currentIndex = yq_controller_array.firstIndex(of: currentVC) {
            let direction: UIPageViewController.NavigationDirection = pageIndex > currentIndex ? .forward : .reverse
            setViewControllers([targetVC], direction: direction, animated: true, completion: nil)
        }
    }
}

extension JY_Driving_Test_Essentials_Directory_PageController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置数据源和委托
        dataSource = self
        delegate = self
        

    }
}

extension JY_Driving_Test_Essentials_Directory_PageController {
    func yq_set(titleArray: [JY_Driving_Test_Essentials_Directory_Title_View_Model]) {
        
        for viewModel in titleArray {
            let controller = JY_Driving_Test_Essentials_Video_List_Controller()
            yq_controller_array.append(controller)
        }
        
        if let firstVC = yq_controller_array.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension JY_Driving_Test_Essentials_Directory_PageController: UIPageViewControllerDataSource {
    // 实现数据源方法，返回前一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = yq_controller_array.firstIndex(of: viewController) else {
            return nil
        }
        if currentIndex == 0 {
            return nil
        }
        return yq_controller_array[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = yq_controller_array.firstIndex(of: viewController) else {
            return nil
        }
        if currentIndex == yq_controller_array.count - 1 {
            return nil
        }
        return yq_controller_array[currentIndex + 1]
    }
}

extension JY_Driving_Test_Essentials_Directory_PageController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentVC = pageViewController.viewControllers?.first,
               let currentIndex = yq_controller_array.firstIndex(of: currentVC) {
//                print("当前显示的页面是: \(currentIndex + 1)")
                yq_current_page_index = currentIndex
            }
        }
    }
}
