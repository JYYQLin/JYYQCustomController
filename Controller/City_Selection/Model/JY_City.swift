//
//  JY_City.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City {
    
    /** 城市代码 */
    private(set) lazy var yq_city_code: String = ""
    /** 拼音首字母 */
    private(set) lazy var yq_pinyin_initial: String = ""
    /** 简称 */
    private(set) lazy var yq_abbreviation_name: String = ""
    /** 全称 */
    private(set) lazy var yq_full_name: String = ""
}

extension JY_City {
    func yq_set(dic: [String: Any]) {
        
        let citycode = dic["citycode"] as? Int
        if citycode != nil {
            yq_city_code = "\(citycode!)"
        }else {
            yq_city_code = dic["citycode"] as? String ?? ""
        }
        
        let name = dic["name"] as? String
        if name != nil {
            yq_full_name = name!
        }
        
        let abname = dic["abname"] as? String
        if abname != nil {
            yq_abbreviation_name = abname!
        }
       
        let pinyinInitial = dic["pinyin_initial"] as? String
        if pinyinInitial != nil {
            yq_pinyin_initial = pinyinInitial!
        }
    }
}

extension JY_City {
    func yq_dicString() -> String? {
        let dic: [String: Any] = ["citycode": yq_city_code,
                                  "name": yq_full_name,
                                  "abname": yq_abbreviation_name,
                                  "pinyin_initial": yq_pinyin_initial,
        ]
        
        guard let dicString = JY_Json_Tool.yq_dictionary_to_JSONString(dic) else {
            return nil
        }
        
        return dicString
    }
}
