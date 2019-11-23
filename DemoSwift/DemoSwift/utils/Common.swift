//
//  Common.swift
//  TestAppBack
//
//  Created by hello on 2018/12/16.
//  Copyright © 2018 hello. All rights reserved.
//

import Foundation
import CommonCrypto

let myapi = "http://slavex.3dabuliu.com/app/info"
let APPID = "29fa784a6d39a2795df2b9b913b4320e"
let infoDictionary = Bundle.main.infoDictionary!
let BUNDLEID:String = infoDictionary["CFBundleIdentifier"] as! String


//base64 签名
func base64Encoding(plainString:String)->String  {
    let plainData = plainString.data(using: String.Encoding.utf8)
    let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
    return base64String!
}
//md5加密
func md5String(str:String) -> String{
    let cStr = str.cString(using: String.Encoding.utf8);
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
    CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
    let md5String = NSMutableString();
    for i in 0 ..< 16{
        md5String.appendFormat("%02x", buffer[i])
    }
    free(buffer)
    return md5String as String
}
func changeRequestParams(privateKey:String, dict:Dictionary<String, Any>) -> Dictionary<String, Any> {
    var paramsMap = Dictionary<String, Any>()
    
    let data3 : Data! = try? JSONSerialization.data(withJSONObject: dict, options: []) as Data
    let JSONString = String(data:data3,encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
    
    let data = base64Encoding(plainString: JSONString!)
    //    print("object:\t",data)
    let sign = md5String(str: data + privateKey)
    //    print("data + privateKey:",data + privateKey)
    //    print("sign:\t",sign)
    paramsMap["object"] = data
    paramsMap["sign"] = sign
    return paramsMap
}
