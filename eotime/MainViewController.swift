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

    //xy座標
    var mining_area_x: Int = 0
    var mining_area_y: Int = 0
    var logging_area_x: Int = 0
    var logging_area_y: Int = 0

    //時計
    private var timer = Timer()
    
    //時間帯マーク
    var mark_hour:Int = 0

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
        
        let hour = Int(disp_time.get_hour())!
        switch hour {
        case 0...3:
            time_limit.text = "00:00-03:59"
            mark_hour = 0
        case 4...7:
            time_limit.text = "04:00-07:59"
            mark_hour = 1
        case 8...11:
            time_limit.text = "08:00-11:59"
            mark_hour = 2
        case 12...15:
            time_limit.text = "12:00-15:59"
            mark_hour = 3
        case 16...19:
            time_limit.text = "16:00-19:59"
            mark_hour = 4
        case 20...24:
            time_limit.text = "20:00-24:59"
            mark_hour = 5
        default :
            time_limit.text = "--"
        }

        get_MiningItem(hour: mark_hour)
        get_LoggingItem(hour: mark_hour)
    }

    
    //採掘アイテム
    func get_MiningItem(hour: Int) {
        let itemdata = getItem(work: "採掘", hour: hour)
        
        mining_area.text = itemdata.get_area()
        mining_item.text = itemdata.get_item()
        mining_area_x = itemdata.get_x()
        mining_area_y = itemdata.get_y()
        //枠線にクリスタルの色をつける
        let color = getColor(elementName: itemdata.get_element())
        self.mining.layer.borderColor = color.crystalColor().cgColor

    }
    
    //伐採アイテム
    func get_LoggingItem(hour: Int){
        let itemdata = getItem(work: "園芸", hour: hour)
        
        logging_area.text = itemdata.get_area()
        logging_item.text = itemdata.get_item()
        logging_area_x = itemdata.get_x()
        logging_area_y = itemdata.get_y()
        //枠線にクリスタルの色をつける
        let color = getColor(elementName: itemdata.get_element())
        self.Logging.layer.borderColor = color.crystalColor().cgColor
    }

    
    @IBAction func tap_mining(_ sender: Any) {
        let v = WorklistViewController()
        v.para_work = "採掘"
        v.para_hour = mark_hour
        v.para_x = mining_area_x
        v.para_y = mining_area_y
        v.mapname = mining_area.text!
        v.modalPresentationStyle = .custom
        v.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        present(v, animated: true, completion: nil)
    }
    
    @IBAction func tap_logging(_ sender: Any) {
        let v = WorklistViewController()
        v.para_work = "園芸"
        v.para_hour = mark_hour
        v.para_x = logging_area_x
        v.para_y = logging_area_y
        v.mapname = logging_area.text!
        v.modalPresentationStyle = .custom
        v.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        present(v, animated: true, completion: nil)
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
