//
//  CBSceneCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSceneCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func configTitle(title:String){
        self.nameLabel.text = title
    }
    
    class func createSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:CBRecommendWidgeListModel)->CBSceneCell{
        
        let cellId = "sceneCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSceneCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CBSceneCell", owner: nil, options: nil).last as? CBSceneCell
        }
        if let title = model.title{
            cell?.configTitle(title)
        }
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
