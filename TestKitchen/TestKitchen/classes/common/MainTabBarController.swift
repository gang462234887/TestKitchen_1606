//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var bgView:UIView?
    //json对应的数组
    private var array:Array<Dictionary<String,String>>?{
        get{
            let path = NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
            
            var myArray:Array<Dictionary<String,String>>? = nil
            if let filePath = path{
                let data = NSData(contentsOfFile: filePath)
                do{
                    let jsonValue = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                    if jsonValue.isKindOfClass(NSArray.self){
                        myArray = jsonValue as? Array<Dictionary<String,String>>
                    }
                }catch{
                    print(error)
                    return nil
                }
                
            }
            return myArray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createViewControllers()
    }
    
    //创建视图控制器
    func createViewControllers(){

        var ctrlNames = [String]()
        var imageNames = [String]()
        var titleNames = [String]()
        
        if let tmpArray = self.array{
            
            for dict in tmpArray{
                let name = dict["ctrlName"]
                let titleName = dict["titleName"]
                let imageName = dict["imageName"]
                
                ctrlNames.append(name!)
                titleNames.append(titleName!)
                imageNames.append(imageName!)
            }
        }else{
            ctrlNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            //home_normal@2x home_select@2x  community_normal@2x community_select@2x  shop_normal@2x shop_select@2x  shike_normal@2x shike_select@2x  mine_normal@2x mine_select@2x
            titleNames = ["食材","社区","商城","食课","我的"]
            imageNames = ["home","community","shop","shike","mine"]
            
        }
        
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlNames.count{
            
            let ctrlName =  "TestKitchen." + ctrlNames[i]
            
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
        }
        
        self.viewControllers = vCtrlArray
        
        //自定制tabbar
        
        self.createCustomTabbar(titleNames, imageNames: imageNames)
    }
    
    //自定制tabbar
    func createCustomTabbar(titleNames:[String],imageNames:[String]){
        self.bgView = UIView.createView()
        self.bgView?.backgroundColor = UIColor.whiteColor()
        self.bgView?.layer.borderWidth = 1
        self.bgView?.layer.borderColor = UIColor.grayColor().CGColor
        self.view.addSubview(self.bgView!)
        
        self.bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo((self?.view)!)
            make.top.equalTo((self?.view.snp_bottom)!).offset(-49)
            
            let width = kScreenWidth/5.0
            for i in 0..<imageNames.count{
                let imageName = imageNames[i]
                let titleName = titleNames[i]
                
                let bgImageName = imageName+"_normal"
                let selectBgImageName = imageName+"_select"
                let btn = UIButton.createBtn(nil, bgImageName: bgImageName, selectBgImageName: selectBgImageName, target: self, action: #selector(self!.clickBtn(_:)))
                btn.tag = 300+i
                self?.bgView?.addSubview(btn)
                
                btn.snp_makeConstraints(closure: {
                    [weak self]
                    (make) in
                    make.top.bottom.equalTo((self?.bgView)!)
                    make.width.equalTo(width)
                    make.left.equalTo(width*CGFloat(i))
                })
                let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: UIColor.grayColor())
                label.tag = 400
                btn.addSubview(label)
                
                label.snp_makeConstraints(closure: { (make) in
                    make.left.right.equalTo(btn)
                    make.top.equalTo(btn).offset(32)
                    make.height.equalTo(12)
                })
                
                if i == 0{
                    btn.selected = true
                    label.textColor = UIColor.orangeColor()
                }
            }
        })
        
    }
    
    func clickBtn(curBtn:UIButton){
        
        //1.取消之前选中按钮的状态
        let lastBtnView = self.view.viewWithTag(300+selectedIndex)
        if let tmpBtn = lastBtnView{
            let lastBtn = tmpBtn as! UIButton
            let lastView = tmpBtn.viewWithTag(400)
            if let tmpLabel = lastView{
                let lastLbael = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLbael.textColor = UIColor.grayColor()
            }
        }
        //2.设置当前选中按钮的状态
        let curLabelView = curBtn.viewWithTag(400)
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            
            curBtn.selected = true
            curLabel.textColor = UIColor.orangeColor()
        }
        
        //选中视图控制器
        selectedIndex = curBtn.tag - 300
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
