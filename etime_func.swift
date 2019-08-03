//
//  etime_func.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/03.
//  Copyright © 2019 shokoni. All rights reserved.
//

import Foundation

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
