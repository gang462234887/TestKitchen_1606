//
//  CBRecommendModel.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendModel: NSObject {
    
    var code:NSNumber?
    var msg:Bool?
    var version:String?
    var timestamp:NSNumber?
    var data:CBRecommendDataModel?

}

class CBRecommendDataModel:NSObject{
    var banner:Array<CBRecommendBannerModel>?
    var widgetList:Array<CBRecommendWidgeListModel>?
}


class CBRecommendBannerModel:NSObject{
    var banner_id:NSNumber?
    var banner_title:String?
    var banner_picture:String?
    
    var banner_link:String?
    var is_link:String?
    var refer_key:String?
    
    var type_id:String?
    
}

class CBRecommendWidgeListModel:NSObject{
    
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    var title:String?
    
    var title_link:String?
    var desc:String?
    var widget_data:Array<CBRecommendWidgetDataModel>?
    
}

class CBRecommendWidgetDataModel:NSObject{
    
    var id:NSNumber?
    var type:String?
    var content:String?
    var link:String?
    
}






