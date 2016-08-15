//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
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
        
        //let ctrlNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        var ctrlNames = [String]()
        
        if let tmpArray = self.array{
            
            for dict in tmpArray{
                let name = dict["ctrlName"]
                ctrlNames.append(name!)
            }
        }else{
            ctrlNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
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
