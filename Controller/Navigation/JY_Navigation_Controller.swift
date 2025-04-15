//
//  JY_Navigation_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit

let JY_NotificationName_TabBar_Hidden = "JY_NotificationName_TabBar_Hidden"

open class JY_Navigation_Controller: UINavigationController {
    
    private lazy var yq_light_preferredStatusBarStyle: Bool = false
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return yq_light_preferredStatusBarStyle == true ? .lightContent : .darkContent
        }
    }
    
    /** 日间模式导航栏配置, 不传则会自用适配默认配置*/
    public lazy var yq_light_appearance: UINavigationBarAppearance? = nil {
        didSet {
            yq_set_light_navigationBar()
        }
    }
    
    private lazy var yq_default_light_appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  JY_Navigation_Controller.yq_title_light_textColor(), NSAttributedString.Key.font: JY_Navigation_Controller.yq_title_font()]
        
        appearance.backgroundColor = UIColor(named: "JY_Navigation_Bar_BgColor")
        
        return appearance
    }()
    
    
    /** 夜间模式导航栏配置, 不传则会自用适配默认配置*/
    public lazy var yq_dark_appearance: UINavigationBarAppearance? = nil {
        didSet {
            yq_set_dark_navigationBar()
        }
    }
    
    private lazy var yq_default_dark_appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  JY_Navigation_Controller.yq_title_dark_textColor(),  NSAttributedString.Key.font: JY_Navigation_Controller.yq_title_font()]
        
        appearance.backgroundColor = UIColor(named: "JY_Navigation_Bar_Dark_BgColor")
        
        return appearance
    }()
}

extension JY_Navigation_Controller {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        yq_remake_popGestureRecognizer()
        
        yq_set_light_navigationBar()
    }
}

extension JY_Navigation_Controller {
    /**
        修改状态栏模式
     isLight: true表示lightContent, false表示darkContent
     */
    @objc dynamic open func yq_light_preferredStatusBarStyle(_ isLight: Bool) {
        yq_light_preferredStatusBarStyle = isLight
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: 导航条样式相关
extension JY_Navigation_Controller {
    @objc dynamic open func yq_set_light_navigationBar() {

        navigationBar.standardAppearance = yq_light_appearance ?? yq_default_light_appearance
        
        if #available(iOS 15.0, *) {
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.titleTextAttributes = navigationBar.standardAppearance.titleTextAttributes
        }
    }
    
    @objc dynamic open func yq_set_dark_navigationBar() {

        navigationBar.standardAppearance = yq_dark_appearance ?? yq_default_dark_appearance
        
        if #available(iOS 15.0, *) {
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.titleTextAttributes = navigationBar.standardAppearance.titleTextAttributes
        }
    }
    
    /// 重写pushViewController
    /*
     统一设置返回按钮图片
     统一设置push后隐藏TabBar
     */
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(JY_NotificationName_TabBar_Hidden), object: nil)
            viewController.hidesBottomBarWhenPushed = true
            
            let backButton = UIButton(type: .custom)
            backButton.setImage(UIImage(named: JY_Navigation_Controller.yq_normal_back_imageName()), for: .normal)
            backButton.setImage(UIImage(named: JY_Navigation_Controller.yq_normal_back_imageName()), for: .highlighted)
            backButton.sizeToFit()
            backButton.addTarget(self, action: #selector(yq_back_click), for: .touchUpInside)
            
            let view = UIView(frame:backButton.frame)
            view.addSubview(backButton)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
        }
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - 交互事件
extension JY_Navigation_Controller {
    @objc fileprivate func yq_back_click() {
        view.endEditing(true)
        _ = popViewController(animated: true)
    }
}

// MARK: - 恢复边缘滑动返回手势
extension JY_Navigation_Controller : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return children.count != 1
    }
    
    /// 设置滑动手势
    fileprivate func yq_remake_popGestureRecognizer() {
        interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
    }
}
