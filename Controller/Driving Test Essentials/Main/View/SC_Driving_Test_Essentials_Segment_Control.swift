//
//  JY_Driving_Test_Essentials_Segment_Control.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Segment_Control: JY_View {
    
    var yq_title_click_block: ((_ index: Int) -> Void)?
    
    private lazy var yq_scroll_progress: Float = 0

    private lazy var yq_title1_button: JY_Button = JY_Button()
    private lazy var yq_title2_button: JY_Button = JY_Button()

    private lazy var yq_underLine_view: JY_ImageView = JY_ImageView()
}

extension JY_Driving_Test_Essentials_Segment_Control {
    func yq_set(scrollProgress: Float) {
        yq_scroll_progress = scrollProgress
        
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.layoutSubviews()
        }
    }
}

extension JY_Driving_Test_Essentials_Segment_Control {
    @objc private func yq_title_click(button: UIButton) {
        
        yq_set(scrollProgress: Float(button.tag))
        
        if yq_title_click_block != nil {
            yq_title_click_block!(button.tag)
        }
    }
}

extension JY_Driving_Test_Essentials_Segment_Control {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_title1_button)
        addSubview(yq_title2_button)
        yq_title1_button.addTarget(self, action: #selector(yq_title_click(button:)), for: .touchUpInside)
        yq_title2_button.addTarget(self, action: #selector(yq_title_click(button:)), for: .touchUpInside)
        
        addSubview(yq_underLine_view)
    }
}

extension JY_Driving_Test_Essentials_Segment_Control {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title1_button_frame()
        yq_title2_button_frame()
        yq_underLine_view_frame()
    }
    
    private func yq_title1_button_frame() {
        
        yq_title1_button.frame.origin = {
            yq_title1_button.tag = 0
            
            let text = "简介"
            
            let progress = (1.0 - yq_scroll_progress * 1.0)
            
            let scrollProgress = progress <= 0 ? 0 : progress
            
            let fontSize = 15.0 + scrollProgress * 3.0
            
            let redColor = CGFloat(97.0 - scrollProgress * 64.0)
            let greenColor = CGFloat(97.0 - scrollProgress * 64.0)
            let blueColor = CGFloat(97.0 - scrollProgress * 64.0)
            
            let attributedString = NSMutableAttributedString(string: text)
            
//            let font = scrollProgress > 0.5 ? UIFont.yq_medium_font(CGFloat(fontSize)) : UIFont.yq_system_font(CGFloat(fontSize))            
            let font = UIFont.yq_medium_font(CGFloat(fontSize))
            
            attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(.foregroundColor, value: UIColor.yq_color(red: redColor, green: greenColor, blue: blueColor), range: NSRange(location: 0, length: attributedString.length))
            
            yq_title1_button.setAttributedTitle(attributedString, for: .normal)
            yq_title1_button.sizeToFit()
            
            return CGPoint(x: 0, y: (frame.height - yq_title1_button.frame.height) * 0.5)
        }()
    }
    
    private func yq_title2_button_frame() {
        
        yq_title2_button.frame.origin = {
            yq_title2_button.tag = 1
            
            let text = "目录"
            
            let progress = yq_scroll_progress * 1.0
            
            let scrollProgress = progress <= 0 ? 0 : progress
            
            let fontSize = 15.0 + scrollProgress * 3.0
            
            let redColor = CGFloat(97.0 - scrollProgress * 64.0)
            let greenColor = CGFloat(97.0 - scrollProgress * 64.0)
            let blueColor = CGFloat(97.0 - scrollProgress * 64.0)
            
            let attributedString = NSMutableAttributedString(string: text)
        
//            let font = scrollProgress > 0.5 ? UIFont.yq_medium_font(CGFloat(fontSize)) : UIFont.yq_system_font(CGFloat(fontSize))
            let font = UIFont.yq_medium_font(CGFloat(fontSize))
            
            print("字体是 = \(font) scrollProgress = \(scrollProgress)")
            
            attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(.foregroundColor, value: UIColor.yq_color(red: redColor, green: greenColor, blue: blueColor), range: NSRange(location: 0, length: attributedString.length))
            
            yq_title2_button.setAttributedTitle(attributedString, for: .normal)
            yq_title2_button.sizeToFit()
            
            return CGPoint(x: frame.width - yq_title2_button.frame.width, y: (frame.height - yq_title2_button.frame.height) * 0.5)
        }()
    }
    
    private func yq_underLine_view_frame() {
        yq_underLine_view.frame.origin = {
            yq_underLine_view.frame.size = CGSize(width: 21 * yq_scale, height: 3 * yq_scale)
            yq_underLine_view.image = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "#FF6A08"), imageSize: yq_underLine_view.frame.size, cornerRadius: yq_underLine_view.frame.height * 0.5)
            
            let progress = yq_scroll_progress * 1.0
            
            let scrollProgress = progress <= 0 ? 0 : progress
            
            let x = ((yq_title2_button.frame.midX - yq_title1_button.frame.midX) * CGFloat(scrollProgress) + yq_title1_button.frame.midX) - yq_underLine_view.frame.width * 0.5
            
            return CGPoint(x: x, y: frame.height - yq_underLine_view.frame.height)
        }()
    }
}
