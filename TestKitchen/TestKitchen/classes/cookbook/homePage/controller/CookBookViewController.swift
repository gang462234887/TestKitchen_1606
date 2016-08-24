//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {
    
    //滚动视图
    var scrollView:UIScrollView?
    
    //食材首页的推荐视图
    private var recommendView:CBRecommendView?
    
    //首页的食材视图
    private var foodView:CBMaterialView?
    
    ////首页的分类视图
    private var categoryView:CBMaterialView?
    
    private var segCtrl:KTCSegmentCtrl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createMyNav()
        
        self.createHomePageView()
        
        //下载推荐的数据
        self.downloadFoodData()
        
        //下载食材的数据
        self.downloaderRecommendData()
        
        //下载分类的数据
        self.downloadCategoryData()
    }
    
    //下载分类的数据
    func downloadCategoryData(){
        //methodName=CategoryIndex&token=&user_id=&version=4.32
        let params = ["methodName":"CategoryIndex"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .Category
        
        downloader.postWithUrl(kHostUrl, params: params)
    }
    
    
    //下载食材的数据
    func downloadFoodData(){
        
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        
        downloader.type = .FoodMaterial
        
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    
    //下载推荐的数据
    func createHomePageView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //1.创建滚动视图
        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        
        scrollView?.delegate = self
        view.addSubview(scrollView!)
        
        scrollView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo((self?.view)!).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //2.创建容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        
        //3.添加子视图
        
        
        //3.1推荐
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
            
        })
        
        //3.2食材
        foodView = CBMaterialView()
        containerView.addSubview(foodView!)
        
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        //3.3分类
        
        categoryView = CBMaterialView()
        containerView.addSubview(categoryView!)
        
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
        })
        
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
    }
    
    //创建导航
    func createMyNav(){
        
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth-80*2, 44), titleNames: ["推荐","食材","分类"])
        navigationItem.titleView = segCtrl
        segCtrl?.delegate = self
        
        
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
    }
    
    //下载推荐的数据
    func downloaderRecommendData(){

        let dict = ["methodName":"SceneHome"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        
        downloader.type = .Recommend
        
        downloader.postWithUrl(kHostUrl, params: dict)
        
        
    }
    
    //扫一扫
    func scanAction(){
        
    }
    
    //搜索
    func searchAction(){
        
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

extension CookBookViewController:KTCDownloaderDelegate{
    
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        if downloader.type == .Recommend {
            //推荐
            if let jsonData = data{
                let model = CBRecommendModel.parseModel(jsonData)
                
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.recommendView?.model = model
                    })
            }
        }else if downloader.type == .FoodMaterial{
            //食材
            /*
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(str!)
             */
            if let jsonData = data{
                let model = CBMaterialModel.parseModelWithData(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.foodView?.model = model
                })
            }
        }else if downloader.type == .Category{
            //分类
            if let jsonData = data{
                let model = CBMaterialModel.parseModelWithData(jsonData)
                dispatch_async(dispatch_get_main_queue(), { 
                    [weak self] in
                    self?.categoryView?.model = model
                })
            }
        }

    }
}

extension CookBookViewController:KTCSegmentCtrlDelegate{
    
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, atIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(kScreenWidth*CGFloat(index), 0), animated: true)
    }
    
}


extension CookBookViewController:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        
        segCtrl?.selectIndex = index
        
    }
    
    
}











