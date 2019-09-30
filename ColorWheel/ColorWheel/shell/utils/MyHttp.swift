//
//  MyHttp.swift
//  Swift_Info
//
//  Created by hello on 2018/12/16.
//  Copyright © 2018 William. All rights reserved.
//

import Alamofire

enum MethodType {
    case get
    case post
    case put
    case delete
}

class MyHttp {
    
    private static var instance:MyHttp? = nil
    private init (){}
    
    class func shareManager() -> MyHttp {
        if instance == nil {
            instance = MyHttp.init()
        }
        return instance!
    }
    
    let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()

    func request(urlString:String, method:MethodType, parameters:Dictionary<String, Any>?, headers:Dictionary<String, String>?, success:@escaping(_ responseObject:Any) -> Void, failure:@escaping(_ error:Error) -> Void) {
        
        let myMethod:HTTPMethod
        switch method {
        case .get:
            myMethod = .get
        case .post:
            myMethod = .post
        case .put:
            myMethod = .put
        default:
            myMethod = .get
        }
        
        
        sharedSessionManager.request(urlString, method:myMethod, parameters:parameters, encoding:JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value {
                    //先将json对象转换成data
                    let data = try? JSONSerialization.data(withJSONObject: value, options: [])
                    //再将data转换成字符串
                    let resultStr = String(data: data!, encoding: String.Encoding.utf8)
                    success(resultStr!)
                }
            case .failure(let error):
                failure(error)
            }
        }
        
    }

}
