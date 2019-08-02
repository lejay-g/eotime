//
//  MainViewController.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/02.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var time_hour: UILabel!
    @IBOutlet weak var time_minute: UILabel!
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var minute: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //現在のunix時刻を取得
        let timeInterval = NSDate().timeIntervalSince1970
        
        //エオルゼア時間60分=リアル時間175秒
        let et_seconds = timeInterval * 60.0 / 175.0
        let et_hours = timeInterval / 175.0
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
        //時
        let disp_et_hour = Int(et_hours.truncatingRemainder(dividingBy: 24.0))
        //分
        let disp_et_minute = Int(et_seconds.truncatingRemainder(dividingBy: 60.0))
        
        //debug
        year.text = String(disp_et_year)
        month.text = String(disp_et_month)
        day.text = String(disp_et_day)
        hour.text = String(disp_et_hour)
        minute.text = String(disp_et_minute)
        
        //disp
        time_hour.text = String(disp_et_hour)
        time_minute.text = String(disp_et_minute)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
