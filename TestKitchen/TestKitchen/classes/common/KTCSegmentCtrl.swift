//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol KTCSegmentCtrlDelegate:NSObjectProtocol {
    func didSelectSegCtrl(segCtrl:KTCSegmentCtrl,atIndex index:Int)
}

class KTCSegmentCtrl: UIView {
    
    weak var delegate: KTCSegmentCtrlDelegate?
    
    var selectIndex:Int = 0{
        didSet{
            if selectIndex != oldValue{
                selectBtnAtIndex(selectIndex,lastIndex: oldValue)
            }
            
        }
    }
    
    private var lineView:UIView?

    init(frame: CGRect,titleNames:[String]) {
        super.init(frame: frame)
        
        if titleNames.count > 0{
            let w = bounds.size.width/CGFloat(titleNames.count)
            
            for i in 0..<titleNames.count{
                let frame = CGRectMake(CGFloat(i)*w, 0, w, bounds.size.height)
                
                let btn = KTCSegmentBtn(frame: frame)
                btn.configTitle(titleNames[i])
                
                btn.tag = 300+i
                //点击事件
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                
                addSubview(btn)
                if i == 0{
                    btn.clicked = true
                }
            }
            
            lineView = UIView.createView()
            lineView?.backgroundColor = UIColor.orangeColor()
            lineView?.frame = CGRectMake(0, bounds.size.height-2, w, 2)
            addSubview(lineView!)
        }

    }

    
    func selectBtnAtIndex(index:Int,lastIndex:Int){
        //如果点击的是选中的按钮
        let curBtn = viewWithTag(300+index)
        if ((curBtn?.isKindOfClass(KTCSegmentBtn.self)) == true){
            let btn = curBtn as! KTCSegmentBtn
            btn.clicked = true
        }

        //取消上次选中的按钮
        let lastBtn = self.viewWithTag(300+lastIndex)
        
        if ((lastBtn?.isKindOfClass(KTCSegmentBtn.self)) == true){
            let lastSegBtn = lastBtn as! KTCSegmentBtn
            lastSegBtn.clicked = false
        }
        //修改当前选中的序号
        //selectIndex = index
        lineView?.frame.origin.x = (lineView?.bounds.size.width)!*CGFloat(selectIndex)
        
    }
    
    func clickBtn(btn:KTCSegmentBtn){
        
        if btn.tag != 300+selectIndex{
            
            //selectBtnAtIndex(btn.tag-300)
            selectIndex = btn.tag - 300
            
            delegate?.didSelectSegCtrl(self, atIndex: selectIndex)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class KTCSegmentBtn:UIControl{
    
    private var label:UILabel?
    
    var clicked:Bool?{
        didSet{
            if clicked == true{
                label?.textColor = UIColor.blackColor()
            }else if clicked == false{
                label?.textColor = UIColor.grayColor()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor.grayColor())
        label?.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height-10)
        addSubview(label!)
        
    }
    
    
    func configTitle(title:String){
        label?.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





