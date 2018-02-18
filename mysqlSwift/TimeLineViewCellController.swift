//
//  TimeLinViewController.swift
//  mysqlSwift
//
//  Created by shin on 2018/02/16.
//  Copyright © 2018年 nishun0419. All rights reserved.
//

import UIKit;

class TimeLineViewCellController: UITableViewCell{
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var example: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true);
    }
}
