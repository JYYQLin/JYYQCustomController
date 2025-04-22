//
//  JY_City_SearchBar.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_SearchBar: JY_View {
    
    var yq_textField_change_block: ((_ text: String) -> Void)?
    var yq_search_click_block: ((_ text: String) -> Void)?
    
    private lazy var yq_bg_imageView: JY_ImageView = JY_ImageView()
    private lazy var yq_search_imageView: JY_ImageView = JY_ImageView()
    private lazy var yq_textField: JY_TextField = JY_TextField()
    
}

extension JY_City_SearchBar {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_bg_imageView)
        addSubview(yq_search_imageView)
        addSubview(yq_textField)
        
        yq_textField.delegate = self
        yq_textField.addTarget(self, action: #selector(yq_textField_change(textField:)), for: .editingChanged)
    }
    
}

extension JY_City_SearchBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = JY_City_Selection_NavigationBar.yq_navigationBar_bgColor()
        
        yq_bg_imageView.frame.origin = {
            yq_bg_imageView.frame.size = CGSize(width: frame.width, height: 29 * yq_scale)
            yq_bg_imageView.image = UIImage.yq_generate_image(color: JY_City_SearchBar.yq_bgColor(), imageSize: yq_bg_imageView.frame.size, cornerRadius: yq_bg_imageView.frame.height * 0.5)
            return CGPoint(x: (frame.width - yq_bg_imageView.frame.width) * 0.5, y: 0)
        }()
        
        yq_search_imageView.frame.origin = {
            yq_search_imageView.yq_imageName = JY_City_SearchBar.yq_search_icon()
            yq_search_imageView.frame.size = CGSize(width: 18 * yq_scale, height: 18 * yq_scale)
            return CGPoint(x: 15 * yq_scale + yq_bg_imageView.frame.minX, y: yq_bg_imageView.frame.midY - yq_search_imageView.frame.height * 0.5)
        }()
        
        yq_textField.frame.origin = {
            
            let font = UIFont.systemFont(ofSize: 15 * yq_scale)
            
            yq_textField.font = font
            yq_textField.yq_placeholder_font = font
            
            yq_textField.yq_placeholder_color = JY_City_SearchBar.yq_textField_placeholder_color()
            yq_textField.textColor = JY_City_SearchBar.yq_textField_textColor()
            
            yq_textField.placeholder = "请输入城市名称".yq_localized(tableName: "JY_Position")
            
            yq_textField.clearButtonMode = .whileEditing
            yq_textField.returnKeyType = .search
            
            yq_textField.frame.size = CGSize(width: yq_bg_imageView.frame.maxX - yq_search_imageView.frame.maxX - 25 * yq_scale, height: yq_bg_imageView.frame.height)
            
            return CGPoint(x: yq_bg_imageView.frame.maxX - yq_textField.frame.width - 15 * yq_scale, y: yq_bg_imageView.frame.midY - yq_textField.frame.height * 0.5)
        }()
    }
}

extension JY_City_SearchBar: UITextFieldDelegate {
    
    @objc private func yq_textField_change(textField: JY_TextField) {
        if yq_textField_change_block != nil {
            yq_textField_change_block!(textField.text ?? "")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let returnValue = (textField.text?.count ?? 0) > 0
        
        if yq_search_click_block != nil && returnValue == true {
            yq_search_click_block!(textField.text ?? "")
        }
        
        return returnValue
    }
}
