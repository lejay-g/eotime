//
//  etime_func.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/03.
//  Copyright © 2019 shokoni. All rights reserved.
//

import Foundation

public let mining_data = """
[
    {
        "hour":0,
        "area":"ギラバニア湖畔地帯(x13,y16)",
        "name":"アルマンディン",
        "element":"炎"
    },
    {
        "hour":4,
        "area":"高地ドラヴァニア(x17,y27)",
        "name":"レイディアントファイアグラベル",
        "element":"炎"
    },
    {
        "hour":8,
        "area":"低地ドラヴァニア(x26,y24)",
        "name":"レイディアントファイアグラベル",
        "element":"炎"
    },
    {
        "hour":12,
        "area":"アジムステップ(x29,y15)",
        "name":"ショール",
        "element":"雷"
    },
    {
        "hour":16,
        "area":"アバラシア雲海(x34,y30)",
        "name":"レイディアントライトニンググラベル",
        "element":"雷"
    },
    {
        "hour":20,
        "area":"クルザス西部高地(x21,y28)",
        "name":"レイディアントライトニンググラベル",
        "element":"雷"
    }
]
""".data(using: .utf8)!

public let logging_data = """
[
    {
        "hour":0,
        "area":"クルザス西部高地(x10,y14)",
        "name":"クラリーセージ",
        "element":"風"
    },
    {
        "hour":4,
        "area":"ギラバニア湖畔地帯(x28,y10)",
        "name":"トレヤの枝",
        "element":"氷"
    },
    {
        "hour":8,
        "area":"高地ドラヴァニア(x10,y32)",
        "name":"メネフィナローレル",
        "element":"氷"
    },
    {
        "hour":12,
        "area":"休め",
        "name":"休め",
        "element":"なし"
    },
    {
        "hour":16,
        "area":"高地ドラヴァニア(x10,y32)",
        "name":"メネフィナローレル",
        "element":"氷"
    },
    {
        "hour":20,
        "area":"アバラシア雲海(x23,y12)",
        "name":"クラリーセージ",
        "element":"風"
    }
]
""".data(using: .utf8)!


struct workItem: Codable {
    var hour: Int
    var area: String
    var name: String
    var element: String
}

//アイテム取得
public class getItem {
    var work: String
    var hour: Int
    
    public init(work: String, hour: Int){
        self.work = work
        self.hour = hour
    }
    
    //アイテム名
    public func get_item() -> String{
        var items: [workItem]?
        if work == "採掘" {
            items = try? JSONDecoder().decode([workItem].self, from: mining_data)
        }else{
            items = try? JSONDecoder().decode([workItem].self, from: logging_data)
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        return items![hour].name
    }

    //取得エリア
    public func get_area() -> String{
        var items: [workItem]?
        if work == "採掘" {
            items = try? JSONDecoder().decode([workItem].self, from: mining_data)
        }else{
            items = try? JSONDecoder().decode([workItem].self, from: logging_data)
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        return items![hour].area
    }
    
    //属性名
    public func get_element() -> String{
        var items: [workItem]?
        if work == "採掘" {
            items = try? JSONDecoder().decode([workItem].self, from: mining_data)
        }else{
            items = try? JSONDecoder().decode([workItem].self, from: logging_data)
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        return items![hour].element
    }
}

//時間取得クラス
public class etime {
    var utime: TimeInterval
    
    public init(utime: TimeInterval){
        self.utime = utime
    }
    
    //エオルゼア時間：時
    public func get_hour() -> String{
        //エオルゼア時間60分=リアル時間175秒
        let et_hours = utime / 175.0
        //時
        let disp_et_hour = Int(et_hours.truncatingRemainder(dividingBy: 24.0))
        //0詰め
        return String(format: "%02d", disp_et_hour)
    }
    
    //エオルゼア時間：分
    public func get_minute() -> String{
        //エオルゼア時間60分=リアル時間175秒
        let et_seconds = utime * 60.0 / 175.0
        //分
        let disp_et_minute = Int(et_seconds.truncatingRemainder(dividingBy: 60.0))
        //0詰め
        return String(format: "%02d", disp_et_minute)
    }
    
    //エオルゼア日付取得(未使用)
    public func get_date() -> String {
        //エオルゼア時間60分=リアル時間175秒
        let et_hours = utime / 175.0
        //エオルゼア1日24時間
        let et_days = et_hours / 24.0
        //エオルゼア1ヶ月32日
        let et_months = et_days / 32.0
        
        //年
        let disp_et_year = Int(et_months / 12.0 + 1.0)
        //月
        let disp_et_month = Int(et_months.truncatingRemainder(dividingBy: 12.0) + 1.0)
        //日
        let disp_et_day = Int(et_days.truncatingRemainder(dividingBy: 32.0) + 1.0)
        
        let ret_disp = String(disp_et_year) + "-" + String(disp_et_month) + "-" + String(disp_et_day)
        
        return ret_disp
        
    }
}

//渡された属性のUIColorを返す
public class getColor {

    var elementName: String
    public init(elementName: String){
        self.elementName = elementName
    }

    public func crystalColor() -> UIColor{
        var crystalColor: UIColor

        switch elementName {
        case "炎":
            //#c97586
            crystalColor = UIColor(red: 201/255,
                              green: 117/255,
                              blue: 134/255,
                              alpha: 1)
        case "氷":
            //#eaedf7
            crystalColor = UIColor(red: 234/255,
                              green: 237/255,
                              blue: 247/255,
                              alpha: 1)
        case "風":
            //#d6e9ca
            crystalColor = UIColor(red: 216/255,
                              green: 233/255,
                              blue: 202/255,
                              alpha: 1)
        case "雷":
            //#a59aca
            crystalColor = UIColor(red: 165/255,
                              green: 154/255,
                              blue: 202/255,
                              alpha: 1)
        case "土":
            //#f2c9ac
            crystalColor = UIColor(red: 242/255,
                              green: 201/255,
                              blue: 172/255,
                              alpha: 1)
        default:
            crystalColor = UIColor.lightGray
        }
        
        return crystalColor
    }
}
