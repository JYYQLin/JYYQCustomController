//
//  JY_City_Selection_NavigationBar.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_Selection_NavigationBar: JY_View {

    private lazy var yq_title_label: JY_Label = JY_Label()
    private lazy var yq_back_button: JY_Button = JY_Button()
    private lazy var yq_city_searchBar: JY_City_SearchBar = JY_City_SearchBar()

    let yq_city_searchBar_height: CGFloat = 39.0
    
    lazy var yq_hidden_back_button: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
}

extension JY_City_Selection_NavigationBar {
    func yq_add_back_button_target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        yq_back_button.addTarget(target, action: action, for: controlEvents)
    }
}

extension JY_City_Selection_NavigationBar {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_title_label)
        addSubview(yq_back_button)
        addSubview(yq_city_searchBar)
    }
}

extension JY_City_Selection_NavigationBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = JY_City_Selection_NavigationBar.yq_navigationBar_bgColor()
        
        yq_city_searchBar.frame.origin = {
            yq_city_searchBar.frame.size = CGSize(width: frame.width - 15 * yq_scale * 2, height: yq_city_searchBar_height)
            yq_city_searchBar.yq_set(scale: yq_scale)
            return CGPoint(x: (frame.width - yq_city_searchBar.frame.width) * 0.5, y: frame.height - yq_city_searchBar.frame.height)
        }()
        
        yq_title_label.frame.origin = {
            yq_title_label.text = "选择城市"
            yq_title_label.font = UIFont.yq_medium_font(16 * yq_scale)
            yq_title_label.textColor = JY_City_Selection_NavigationBar.yq_navigationBar_title_textColor()
            yq_title_label.yq_set(scale: yq_scale)
            yq_title_label.sizeToFit()
            
            let y = (yq_current_device.yq_navigationBar_height() - yq_title_label.frame.height) * 0.5
            
            return CGPoint(x: (frame.width - yq_title_label.frame.width) * 0.5, y: yq_city_searchBar.frame.minY - yq_title_label.frame.height - y)
        }()
        
        yq_back_button.frame.origin = {
            
            let height = yq_current_device.yq_navigationBar_height()
            
            yq_back_button.setImage(UIImage(named: JY_Navigation_Controller.yq_normal_back_imageName()), for: .normal)
            yq_back_button.setImage(UIImage(named: JY_Navigation_Controller.yq_normal_back_imageName()), for: .highlighted)
            
            yq_back_button.frame.size = CGSize(width: height, height: height)
            yq_back_button.yq_set(scale: yq_scale)
            
            yq_back_button.isHidden = yq_hidden_back_button
            
            return CGPoint(x: 5 * yq_scale, y: (yq_title_label.frame.midY - yq_back_button.frame.height * 0.5))
        }()
    }
}
