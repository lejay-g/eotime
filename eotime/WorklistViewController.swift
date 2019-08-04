//
//  WorklistViewController.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/03.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit
import etimeFunc

class WorklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var para_work: String = ""
    var para_hour: Int = 0
    
    @IBOutlet weak var worktbl: UITableView!
    @IBOutlet weak var baseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "WorklistTableViewCell", bundle: nil)
        worktbl.delegate = self
        worktbl.dataSource = self
        worktbl.register(nib, forCellReuseIdentifier: "Cell")
        worktbl.estimatedRowHeight = 20
        
        worktbl.tableFooterView = UIView() //空白行の線を消す
        
        if para_work == "採掘" {
            baseView.backgroundColor = UIColor(red: 148/255,
                                               green: 132/255,
                                               blue: 104/255,
                                               alpha: 1)
        }else if para_work == "園芸" {
            baseView.backgroundColor = UIColor(red: 145/255,
                                               green: 203/255,
                                               blue: 114/255,
                                               alpha: 1)
        }else{
            baseView.backgroundColor = UIColor.white
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 //max6行
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = worktbl.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorklistTableViewCell
        
        var itemdata: getItem = getItem(work: para_work, hour: 0) //初期化
        
        
        switch para_hour{
        case 0:
            if indexPath.row == 5 {
                itemdata = getItem(work: para_work, hour: 0)
            }else{
                itemdata = getItem(work: para_work, hour: indexPath.row + 1)
            }
        case 1:
            if indexPath.row < 4 {
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row + 2))
            }else{
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row - 4))
            }
        case 2:
            if indexPath.row < 3 {
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row + 3))
            }else{
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row - 3))
            }
        case 3:
            if indexPath.row < 2 {
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row + 4))
            }else{
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row - 2))
            }
        case 4:
            if indexPath.row < 1 {
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row + 5))
            }else{
                itemdata = getItem(work: para_work,
                                   hour: (indexPath.row - 1))
            }
        case 5:
            itemdata = getItem(work: para_work, hour: indexPath.row)
        default:
            itemdata = getItem(work: para_work, hour: indexPath.row)
        }
        
        cell.area.text = itemdata.get_area()
        cell.item.text = itemdata.get_item()
        cell.element.backgroundColor = getColor(elementName: itemdata.get_element()).crystalColor()

        return cell
    }

    @IBAction func btn_close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
