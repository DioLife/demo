//
//  RequestAPI.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/11/23.
//

import UIKit
import Alamofire
import MBProgressHUD

typealias beforeRequestClosure = (_ showDialog:Bool,_ showText:String)->()
typealias afterRequestClosure = (_ returnStatus:Bool,_ resultJson:String)->()

func requestData(curl:String,cm:HTTPMethod,parameters:Parameters=[:],before:@escaping beforeRequestClosure,after:@escaping afterRequestClosure){
    doRequest(curl: curl, cmethod: cm, params: parameters, before: before, after: after)
}

func expandRequestData(curl:String,cm:HTTPMethod,parameters:Parameters=[:],before:@escaping beforeRequestClosure,after:@escaping afterRequestClosure,maxAge:Int = 15){
    expandDoRequest(curl: curl, cmethod: cm, params: parameters, before: before, after: after, maxAge: maxAge)
}

func expandDoRequest(curl:String,cmethod:HTTPMethod,params:Parameters,
                     before:beforeRequestClosure,after:@escaping afterRequestClosure,maxAge:Int) {
    
    before(true, "正在加载")

    defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
    defaultHeader["User-Agent"] = String.init(format: "ios/%@;iPhone", getVerionName())
    
    Alamofire.request(curl, method: cmethod, parameters: params, encoding: URLEncoding.default, headers: defaultHeader, refreshCache: false)
        .responseString{ (data) in
            
            switch data.result{
            case .success(let json):
                after(true, json)
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    print("request timeout-----------------")
                }
                after(false,String(describing: error))
                break
            }
        }.cache(maxAge: maxAge)
}

func doRequest(curl:String,cmethod:HTTPMethod,params:Parameters,
               before:beforeRequestClosure,after:@escaping afterRequestClosure) {
    
    before(true, "正在加载")

    defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
    defaultHeader["User-Agent"] = String.init(format: "ios/%@;iPhone", getVerionName())
    Alamofire.request(curl, method: cmethod, parameters: params, encoding: URLEncoding.default, headers: defaultHeader)
        .responseString{ (data) in
            
            switch data.result{
            case .success(let json):
                after(true, json)
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //timeout here
                    print("request timeout-----------------")
                }
                after(false,String(describing: error))
                break
            }
    }
}
