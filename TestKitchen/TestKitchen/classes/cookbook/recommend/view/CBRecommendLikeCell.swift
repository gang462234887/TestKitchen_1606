//
//  CBRecommendLikeCell.swift
//  TestKitchen
//
//  Created by gaokunpeng on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CBRecommendLikeCell: UITableViewCell {

    
    
    //显示数据
    var model: CBRecommendWidgeListModel? {
        
        didSet {
            //显示图片和文字
            showData()
        }
    }
    
    
    //显示图片和文字
    func showData(){
        
        for var i in 0..<8 {
            
            //i  0 2 4 6
            //图片
            if model?.widget_data?.count > i {
                
                let imageModel = model?.widget_data![i]
                if imageModel?.type == "image" {
                    
                    //获取图片视图
                    //tag:200 201 202 203
                    let index = i/2
                    let subView = self.contentView.viewWithTag(200+index)
                    if ((subView?.isKindOfClass(UIImageView.self)) == true) {
                        
                        let imageView = subView as! UIImageView
                        let url = NSURL(string: (imageModel?.content)!)
                        imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        
                    }
                    
                    
                    
                }
                
            }
            
            
            //文字
            if model?.widget_data?.count > i+1 {
                
                let textModel = model?.widget_data![i+1]
                
                if textModel?.type == "text" {
                    
                    //tag:300  301  302  303
                    let subView = self.contentView.viewWithTag(300+i/2)
                    if ((subView?.isKindOfClass(UILabel.self)) == true) {
                        let label = subView as! UILabel
                        label.text = textModel?.content
                    }
                    
                }
                
                
            }
            
            
            //每次遍历两个
            i += 1
        }
        
        
    }
    
    
    //创建cell的方法
    class func createLikeCellFor(tableView: UITableView, atIndexPath indexPath:NSIndexPath, withListModel listModel: CBRecommendWidgeListModel) -> CBRecommendLikeCell {
 
            
        //猜你喜欢
        let cellId = "recommendLikeCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendLikeCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendLikeCell", owner: nil, options: nil).last as? CBRecommendLikeCell
        }
        
        cell?.model = listModel
        return cell!
    }
    
    
    @IBAction func clickBtn(sender: UIButton) {
        
        
        
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
