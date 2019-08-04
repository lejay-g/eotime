//
//  WorklistViewController.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/03.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit

let mining_data = """
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

let logging_data = """
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


struct getItem: Codable {
    var hour: Int
    var area: String
    var name: String
    var element: String
}

class WorklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var worktbl: UITableView!

    var items: [getItem]?

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "WorklistTableViewCell", bundle: nil)
        worktbl.delegate = self
        worktbl.dataSource = self
        worktbl.register(nib, forCellReuseIdentifier: "Cell")
        worktbl.estimatedRowHeight = 20
        
        worktbl.tableFooterView = UIView() //空白行の線を消す
        
        //JSONデータをパース
        items = try? JSONDecoder().decode([getItem].self, from: mining_data)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = worktbl.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorklistTableViewCell

        cell.area.text = items![indexPath.row].area
        cell.item.text = items![indexPath.row].name
        
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
