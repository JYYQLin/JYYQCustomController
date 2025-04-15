//
//  JY_City_Selection_View.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JYYQToolBox

class JY_City_Selection_View: JY_View {

    var yq_repositioning_click_block: (() -> Void)?
    var yq_city_click_block: ((_ city: JY_City) -> Void)?
    var yq_keyboard_height_change_block: ((_ height: CGFloat) -> Void)?
    
    private lazy var yq_now_city: JY_City? = nil
    private lazy var yq_allCity_array: [(name: String, cityArray: [JY_City])] = [(name: String, cityArray: [JY_City])]()
    private lazy var yq_hotCity_array: [JY_City] = [JY_City]()
    
    private lazy var yq_float_label: UILabel = UILabel()
    
    private(set) lazy var yq_keyboard_height: CGFloat = 0.001 {
        didSet {
            yq_collectionView.contentInset = UIEdgeInsets(top: 10 * yq_scale, left: 0, bottom: yq_keyboard_height, right: 0)
            yq_collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: yq_keyboard_height, right: 0)
            
            if yq_keyboard_height_change_block != nil {
                yq_keyboard_height_change_block!(yq_keyboard_height)
            }
        }
    }
    
    private lazy var yq_calue_current_cell: JY_City_Selection_Cell = JY_City_Selection_Cell()
    private lazy var yq_collectionView: JY_Refresh_CollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = JY_Refresh_CollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        view.dataSource = self
        view.delegate = self
        
        view.register(JY_City_Selection_Cell.self, forCellWithReuseIdentifier: JY_City_Selection_Cell.yq_ID())
        view.register(JY_City_Selection_Hot_City_Cell.self, forCellWithReuseIdentifier: JY_City_Selection_Hot_City_Cell.yq_ID())
        view.register(JY_City_Selection_All_City_Cell.self, forCellWithReuseIdentifier: JY_City_Selection_All_City_Cell.yq_ID())
        
        view.register(JY_City_Selection_Current_City_Header_Cell.self, forCellWithReuseIdentifier: JY_City_Selection_Current_City_Header_Cell.yq_ID())
        view.register(JY_City_Selection_All_City_Header_Cell.self, forCellWithReuseIdentifier: JY_City_Selection_All_City_Header_Cell.yq_ID())
        
        return view
    }()
    
    private lazy var yq_collectionView_index: JY_Collection_IndexView = {
        let view = JY_Collection_IndexView()
        
        view.collectionDelegate = self
        
        return view
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self)
    }
}

extension JY_City_Selection_View {
    
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_collectionView)
        addSubview(yq_collectionView_index)
        addSubview(yq_float_label)
        
        NotificationCenter.default.addObserver(self, selector: #selector(yq_keyboardWillShow(objc:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(yq_keyboardWillHide(objc:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension JY_City_Selection_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let collectionViewWidth = bounds.width
        let collectionViewHeight = bounds.height
        
        yq_collectionView.frame.origin = {
            yq_collectionView.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)
            yq_collectionView.contentInset = UIEdgeInsets(top: 10 * yq_scale, left: 0, bottom: safeAreaInsets.bottom + yq_keyboard_height, right: 0)
            yq_collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: yq_keyboard_height, right: 0)
            
            yq_collectionView.reloadData()
            
            return CGPoint(x: 0, y: frame.height - collectionViewHeight)
        }()
        
        yq_collectionView_index.frame.origin = {
            
            if yq_collectionView_index.titleIndexes.count <= 0 {
                yq_collectionView_index.frame.size = .zero
            }
            else{
                yq_collectionView_index.frame.size = CGSize(width: 20 * yq_scale, height: CGFloat(yq_collectionView_index.titleIndexes.count) * 16.0)
            }
         
            return CGPoint(x: frame.width - yq_collectionView_index.frame.width, y: (frame.height - yq_collectionView_index.frame.height) * 0.5)
        }()
        
        yq_float_label.frame.origin = {
            yq_float_label.frame.size = CGSize(width: 64 * yq_scale, height: 64 * yq_scale)
            yq_float_label.layer.cornerRadius = 15 * yq_scale
            yq_float_label.layer.masksToBounds = true
            yq_float_label.textAlignment = .center
            yq_float_label.textColor = JY_City_Selection_View.yq_title_textColor()
            yq_float_label.backgroundColor = JY_City_Selection_View.yq_bgColor()
            yq_float_label.isHidden = true
            yq_float_label.alpha = 0
            return CGPoint(x: (bounds.width - yq_float_label.frame.width) * 0.5, y: (bounds.height - yq_float_label.frame.height) * 0.5)
        }()
    }
}

extension JY_City_Selection_View {
    @objc private func yq_repositioning_click() {
        if yq_repositioning_click_block != nil {
            yq_repositioning_click_block!()
        }
    }
}

extension JY_City_Selection_View {
    func yq_set(nowCity: JY_City?, _ allCityArray: [(name: String, cityArray: [JY_City])], _ hotCityArray: [JY_City]) {
        
        yq_now_city = nowCity
        yq_allCity_array = allCityArray
        yq_hotCity_array = hotCityArray
        
        var stringArray = [String]()
        
        stringArray.append("当")
        stringArray.append("热")
        
        for s in allCityArray {
            stringArray.append(s.name)
        }
        
        yq_collectionView_index.frame.size = CGSize(width: 20 * yq_scale, height: CGFloat(stringArray.count) * 16.0)
        yq_collectionView_index.titleIndexes = stringArray
        
        yq_collectionView.reloadData()
    }
}

extension JY_City_Selection_View: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return yq_allCity_array.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0 ? 1 : (section == 1 ? yq_hotCity_array.count : yq_allCity_array[section - 2].cityArray.count)) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_City_Selection_Current_City_Header_Cell.yq_ID(), for: indexPath) as? JY_City_Selection_Current_City_Header_Cell else {
                    return JY_City_Selection_Current_City_Header_Cell()
                }
                
                cell.yq_set(title: "当前定位".yq_localized(tableName: "JY_Position"), scale: yq_scale)
                cell.yq_add_repositioning_button_target(self, action: #selector(yq_repositioning_click), for: .touchUpInside)
                
                return cell
            }
            else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_City_Selection_Cell.yq_ID(), for: indexPath) as? JY_City_Selection_Cell else {
                    return JY_City_Selection_Cell()
                }
                
                cell.yq_set(city: yq_now_city, scale: yq_scale)
                
                return cell
            }
        }
        else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_City_Selection_All_City_Header_Cell.yq_ID(), for: indexPath) as? JY_City_Selection_All_City_Header_Cell else {
                    return JY_City_Selection_All_City_Header_Cell()
                }
                
                cell.yq_set(title: "热门城市".yq_localized(tableName: "JY_Position"), scale: yq_scale, x: 0)
                
                return cell
            }
            else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_City_Selection_Hot_City_Cell.yq_ID(), for: indexPath) as? JY_City_Selection_Hot_City_Cell else {
                    return JY_City_Selection_Hot_City_Cell()
                }
                
                cell.yq_set(city: yq_hotCity_array[indexPath.row - 1], scale: yq_scale)
                
                return cell
            }
        }
        else {
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_City_Selection_All_City_Header_Cell.yq_ID(), for: indexPath) as? JY_City_Selection_All_City_Header_Cell else {
                    return JY_City_Selection_All_City_Header_Cell()
                }
                
                cell.yq_set(title: yq_allCity_array[indexPath.section - 2].name, scale: yq_scale)
                
                return cell
            }
            else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_City_Selection_All_City_Cell.yq_ID(), for: indexPath) as? JY_City_Selection_All_City_Cell else {
                    return JY_City_Selection_All_City_Cell()
                }
                
                let cityArray = yq_allCity_array[indexPath.section - 2].cityArray
                
                cell.yq_set(city: cityArray[indexPath.row - 1], scale: yq_scale, hiddenUnderLine: indexPath.row == 0 || (cityArray.count) == indexPath.row)
                
                return cell
            }
        }
    }
}

extension JY_City_Selection_View: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var city: JY_City? = nil
        
        if indexPath.section == 0 {
            
        }
        else if indexPath.section == 1 {
            
           let index = (indexPath.row - 1)
            
            if index >= 0 && yq_hotCity_array.count > index {
                city = yq_hotCity_array[index]
            }
            
        }
        else {
             
            let index = (indexPath.row - 1)
            
            if index >= 0 && index < yq_allCity_array[indexPath.section - 2].cityArray.count  {
                city = yq_allCity_array[indexPath.section - 2].cityArray[index]
            }
            
        }
        
        if yq_city_click_block != nil && city != nil {
            yq_city_click_block!(city!)
        }
        
    }
}

extension JY_City_Selection_View: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      
        if section == 1 {
            return 9 * yq_scale
        }
        else {
            return 0.001
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if section == 1 {
            return 15 * yq_scale
        }
        else {
            return 0.001
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return .zero
        }
        else if section == 1 {
            return UIEdgeInsets(top: 0, left: 18 * yq_scale, bottom: 15 * yq_scale, right: 18 * yq_scale)
        }
        else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            let height = (indexPath.section == 0 ? 36 * yq_scale : (indexPath.section == 1 ? 30 * yq_scale : 26 * yq_scale))
            return CGSize(width: collectionView.frame.width, height: height)
        }
        else{
            if indexPath.section == 0 {
                return CGSize(width: collectionView.frame.width, height: yq_calue_current_cell.yq_size(city: yq_now_city, scale: yq_scale).height)
            }
            else if indexPath.section == 1 {
                return CGSize(width: 101 * yq_scale, height: 28 * yq_scale)
            }
            else {
                if collectionView.frame.width >= 374.5 * yq_scale * 2 {
                    return CGSize(width: (collectionView.frame.width - 1 * yq_scale) * 0.5, height: 40 * yq_scale)
                }
                else{
                    return CGSize(width: collectionView.frame.width, height: 40 * yq_scale)
                }
            }
        }
    }
}

extension JY_City_Selection_View {
    @objc private func yq_keyboardWillShow(objc: Notification) {
        
        guard let keyboardFrame = objc.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }
        
        yq_keyboard_height = keyboardFrame.height
    }
    
    @objc private func yq_keyboardWillHide(objc: Notification) {
        
        yq_keyboard_height = 0.001
    }
    
}

extension JY_City_Selection_View: JY_Collection_IndexView_Delegate {
    func collectionViewIndex(_ collectionViewIndex: JY_Collection_IndexView, didselectionAtIndex index: Int, withTitle title: String) {
      
        yq_collectionView.scrollToItem(at: IndexPath(item: 0, section: index), at: .top, animated: true)
        
        yq_float_label.text = title
    }
    
    func collectionViewIndexTouchesBegan(_ collectionViewIndex: JY_Collection_IndexView) {
        yq_float_label.alpha = 1
        yq_float_label.isHidden = false
    }
    
    func collectionViewIndexTouchesEnd(_ collectionViewIndex: JY_Collection_IndexView) {
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.yq_float_label.alpha = 0
        }completion: { [weak self] _ in
            self?.yq_float_label.isHidden = true
        }
    }
}
