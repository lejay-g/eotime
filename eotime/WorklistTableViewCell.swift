//
//  WorklistTableViewCell.swift
//  eotime
//
//  Created by 西田祥子 on 2019/08/03.
//  Copyright © 2019 shokoni. All rights reserved.
//

import UIKit

class WorklistTableViewCell: UITableViewCell {

    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var element: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
