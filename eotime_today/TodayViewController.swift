//
//  TodayViewController.swift
//  eotime_today
//
//  Created by 西田祥子 on 2019/08/02.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit
import NotificationCenter
import etimeFunc

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var eotime: UILabel!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
    }

    //時刻表示
    @objc func updateTime() {
        //現在のunix時刻を取得
        let unixtime = NSDate().timeIntervalSince1970
        
        //エオルゼア時刻取得＆表示
        let disp_time = etime(utime: unixtime) //インスタンス
        self.eotime.text = disp_time.get_date()
            + "  "
            + disp_time.get_hour()
            + ":" + disp_time.get_minute()

    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
