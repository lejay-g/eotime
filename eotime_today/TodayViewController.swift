//
//  TodayViewController.swift
//  eotime_today
//
//  Created by 西田祥子 on 2019/08/02.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var etime: UILabel!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
    }

    //時刻表示
    @objc func updateTimer() {
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
        self.etime.text = String(format: "%02d", disp_et_hour) + ":" + String(format: "%02d", disp_et_minute)
        
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
