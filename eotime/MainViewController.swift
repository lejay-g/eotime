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
    
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var mining: UIView!
    @IBOutlet weak var Logging: UIView!
    
    @IBOutlet weak var mining_limit: UILabel!
    @IBOutlet weak var mining_area: UILabel!
    @IBOutlet weak var mining_item: UILabel!
    
    @IBOutlet weak var logging_limit: UILabel!
    @IBOutlet weak var logging_area: UILabel!
    @IBOutlet weak var logging_item: UILabel!
    
    //時計
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        box.layer.cornerRadius = 30
        mining.layer.cornerRadius = 30
        Logging.layer.cornerRadius = 30

        self.disptimer()
       
    }

    //時刻を更新していく
    func disptimer() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    //時刻表示
    @objc private func updateTimer() {
        //現在のunix時刻を取得
        let unixtime = NSDate().timeIntervalSince1970
        
        get_hour(utime: unixtime)
    }

    //エオルゼア時刻取得＆表示
    func get_hour(utime: TimeInterval){
        //エオルゼア時間60分=リアル時間175秒
        let et_seconds = utime * 60.0 / 175.0
        let et_hours = utime / 175.0
        //時
        let disp_et_hour = Int(et_hours.truncatingRemainder(dividingBy: 24.0))
        //分
        let disp_et_minute = Int(et_seconds.truncatingRemainder(dividingBy: 60.0))
        
        //0詰めして表示
        time_hour.text = String(format: "%02d", disp_et_hour)
        time_minute.text = String(format: "%02d", disp_et_minute)
        
        //取得アイテムの表示もここでする
        get_MiningItem(hour: disp_et_hour)
        get_LoggingItem(hour: disp_et_hour)

    }

    //エオルゼア日付取得(未使用)
    func get_date(utime: TimeInterval) -> String {
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
    
    //採掘アイテム
    func get_MiningItem(hour: Int) {
        var ItemName: String = ""
        var AreaName: String = ""
        var Limit: String = ""
        switch hour {
        case 0...3:
            Limit = "00:00-03:59"
            AreaName = "休め"
            ItemName = "休め"
        case 4...7:
            Limit = "04:00-07:59"
            AreaName = "休め"
            ItemName = "休め"
        case 8...11:
            Limit = "08:00-11:59"
            AreaName = "休め"
            ItemName = "休め"
        case 12...15:
            Limit = "12:00-15:59"
            AreaName = "アジムステップ(x29,y15)"
            ItemName = "ショール(雷)"
        case 16...19:
            Limit = "16:00-19:59"
            AreaName = "アバラシア雲海(x34,y30)"
            ItemName = "レイディアントライトニンググラベル(雷)"
        case 20...24:
            Limit = "20:00-24:59"
            AreaName = "クルザス西部高地(x21,y28)"
            ItemName = "レイディアントライトニンググラベル(雷)"
        default:
            Limit = "00:00"
            AreaName = "--"
            ItemName = "--"
        }
        
        mining_limit.text = Limit
        mining_area.text = AreaName
        mining_item.text = ItemName

    }
    
    //伐採アイテム
    func get_LoggingItem(hour: Int){
        var ItemName: String = ""
        var AreaName: String = ""
        var Limit: String = ""
        switch hour {
        case 0...3:
            Limit = "00:00-03:59"
            AreaName = "クルザス西部高地(x10,y14)"
            ItemName = "クラリーセージ(風)"
        case 4...7:
            Limit = "04:00-07:59"
            AreaName = "休め"
            ItemName = "休め"
        case 8...11:
            Limit = "08:00-11:59"
            AreaName = "休め"
            ItemName = "休め"
        case 12...15:
            Limit = "12:00-15:59"
            AreaName = "休め"
            ItemName = "休め"
        case 16...19:
            Limit = "16:00-19:59"
            AreaName = "休め"
            ItemName = "休め"
        case 20...24:
            Limit = "20:00-24:59"
            AreaName = "アバラシア雲海(x23,y12)"
            ItemName = "クラリーセージ(風)"
        default:
            Limit = "00:00"
            AreaName = "--"
            ItemName = "--"
        }

        logging_limit.text = Limit
        logging_area.text = AreaName
        logging_item.text = ItemName
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
