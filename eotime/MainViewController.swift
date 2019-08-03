//
//  MainViewController.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/02.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit
import etimeFunc

class MainViewController: UIViewController {

    @IBOutlet weak var time_hour: UILabel!
    @IBOutlet weak var time_minute: UILabel!
    @IBOutlet weak var time_limit: UILabel!
    
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var mining: UIView!
    @IBOutlet weak var Logging: UIView!
    
    @IBOutlet weak var mining_area: UILabel!
    @IBOutlet weak var mining_item: UILabel!
    
    @IBOutlet weak var logging_area: UILabel!
    @IBOutlet weak var logging_item: UILabel!
    
    //時計
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        box.layer.cornerRadius = 30
        mining.layer.cornerRadius = 30
        Logging.layer.cornerRadius = 30

        mining.layer.borderWidth = 10
        Logging.layer.borderWidth = 10

        self.disptimer()
       
    }

    //時刻を更新していく
    func disptimer() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(self.updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
        
    }
    
    //表示更新
    @objc private func updateTimer() {
        //現在のunix時刻を取得
        let unixtime = NSDate().timeIntervalSince1970

        let disp_time = etime(utime: unixtime)
        time_hour.text = disp_time.get_hour()
        time_minute.text = disp_time.get_minute()
        switch Int(disp_time.get_hour())! {
        case 0...3:
            time_limit.text = "00:00-03:59"
        case 4...7:
            time_limit.text = "04:00-07:59"
        case 8...11:
            time_limit.text = "08:00-11:59"
        case 12...15:
            time_limit.text = "12:00-15:59"
        case 16...19:
            time_limit.text = "16:00-19:59"
        case 20...24:
            time_limit.text = "20:00-24:59"
        default :
            time_limit.text = "--"
        }

        get_MiningItem(hour: Int(disp_time.get_hour())!)
        get_LoggingItem(hour: Int(disp_time.get_hour())!)
    }

    
    //採掘アイテム
    func get_MiningItem(hour: Int) {
        var ItemName: String = ""
        var AreaName: String = ""
        var Element: String = ""
        
        switch hour {
        case 0...3:
            AreaName = "ギラバニア湖畔地帯(x13,y16)"
            ItemName = "アルマンディン"
            Element = "炎"

        case 4...7:
            AreaName = "高地ドラヴァニア(x17,y27)"
            ItemName = "レイディアントファイアグラベル"
            Element = "炎"
        case 8...11:
            AreaName = "低地ドラヴァニア(x26,y24)"
            ItemName = "レイディアントファイアグラベル"
            Element = "炎"
        case 12...15:
            AreaName = "アジムステップ(x29,y15)"
            ItemName = "ショール"
            Element = "雷"
        case 16...19:
            AreaName = "アバラシア雲海(x34,y30)"
            ItemName = "レイディアントライトニンググラベル"
            Element = "雷"
        case 20...24:
            AreaName = "クルザス西部高地(x21,y28)"
            ItemName = "レイディアントライトニンググラベル"
            Element = "雷"
        default:
            AreaName = "--"
            ItemName = "--"
        }
        
        mining_area.text = AreaName
        mining_item.text = ItemName
        
        //枠線にクリスタルの色をつける
        crystalColor(work: "mining", color: Element)

    }
    
    
    //伐採アイテム
    func get_LoggingItem(hour: Int){
        var ItemName: String = ""
        var AreaName: String = ""
        var Element: String = ""
        switch hour {
        case 0...3:
            AreaName = "クルザス西部高地(x10,y14)"
            ItemName = "クラリーセージ"
            Element = "風"
        case 4...7:
            AreaName = "ギラバニア湖畔地帯(x28,y10)"
            ItemName = "トレヤの枝"
            Element = "氷"
        case 8...11:
            AreaName = "高地ドラヴァニア(x10,y32)"
            ItemName = "メネフィナローレル"
            Element = "氷"
        case 12...15:
            AreaName = "休め"
            ItemName = "休め"
        case 16...19:
            AreaName = "高地ドラヴァニア(x10,y32)"
            ItemName = "メネフィナローレル"
            Element = "氷"
        case 20...24:
            AreaName = "アバラシア雲海(x23,y12)"
            ItemName = "クラリーセージ"
            Element = "風"
        default:
            AreaName = "--"
            ItemName = "--"
        }

        logging_area.text = AreaName
        logging_item.text = ItemName

        //枠線にクリスタルの色をつける
        crystalColor(work: "logging", color: Element)
    }
    
    //枠線にcrystalの色を反映
    func crystalColor(work: String, color: String) {
        
        var crystal: CGColor
        switch color {
        case "炎":
            //#c97586
            crystal = UIColor.red.cgColor
            crystal = UIColor(red: 201/255,
                              green: 117/255,
                              blue: 134/255,
                              alpha: 1).cgColor
        case "氷":
            //#eaedf7
            crystal = UIColor(red: 234/255,
                              green: 237/255,
                              blue: 247/255,
                              alpha: 1).cgColor
        case "風":
            //#d6e9ca
            crystal = UIColor(red: 216/255,
                              green: 233/255,
                              blue: 202/255,
                              alpha: 1).cgColor
        case "雷":
            //#a59aca
            crystal = UIColor(red: 165/255,
                              green: 154/255,
                              blue: 202/255,
                              alpha: 1).cgColor
        case "土":
            //#f2c9ac
            crystal = UIColor(red: 242/255,
                              green: 201/255,
                              blue: 172/255,
                              alpha: 1).cgColor
        default:
            crystal = UIColor.lightGray.cgColor
        }
        
        switch work {
        case "logging":
            self.Logging.layer.borderColor = crystal
        case "mining":
            self.mining.layer.borderColor = crystal
        default:
            self.Logging.layer.borderColor = UIColor.clear.cgColor
            self.mining.layer.borderColor = UIColor.clear.cgColor
        }
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
