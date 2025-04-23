//
//  JY_Driving_Test_Essentials_Directory_Title_View_Model.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/23.
//

import UIKit

class JY_Driving_Test_Essentials_Directory_Title_View_Model {
    
    var yq_ID_change_block: (() -> Void)?
    private(set) lazy var yq_ID: String = ""
    
    
    var yq_title_change_block: (() -> Void)?
    private(set) lazy var yq_title: String = ""
    
    
    var yq_data_dic_change_block: (() -> Void)?
    private(set) lazy var yq_data_dic: [String: Any] = [String: Any]()

}

extension JY_Driving_Test_Essentials_Directory_Title_View_Model {
    func yq_set(ID: String, title: String, dic: [String: Any]) {
        
        yq_set(ID: ID)
        yq_set(title: title)
        yq_set(dic: dic)
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_View_Model {
    
    func yq_set(dic: [String: Any]) {
        
        if "\(yq_data_dic)".yq_md5() != "\(dic)".yq_md5() {
            yq_data_dic = dic
            
            if yq_data_dic_change_block != nil {
                yq_data_dic_change_block!()
            }
        }
    }
    
    func yq_set(title: String) {
        
        if yq_title != title {
            yq_title = title
            
            if yq_title_change_block != nil {
                yq_title_change_block!()
            }
        }
    }
    
    func yq_set(ID: String) {
        
        if yq_ID != ID {
            yq_ID = ID
            
            if yq_ID_change_block != nil {
                yq_ID_change_block!()
            }
        }
    }
}
