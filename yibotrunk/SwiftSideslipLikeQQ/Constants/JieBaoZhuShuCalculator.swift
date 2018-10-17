//
//  JieBaoZhuShuCalculator.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/28.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class JieBaoZhuShuCalculator {
    
    static let reg09:String = "^0?1?2?3?4?5?6?7?8?9?|-$";
    static let reg09Comma = "^(0)?((,|\\b)1)?((,|\\b)2)?((,|\\b)3)?((,|\\b)4)?((,|\\b)5)?((,|\\b)6)?((,|\\b)7)?((,|\\b)8)?((,|\\b)9)?$";
    static let reg10 = "^(01)?(02)?(03)?(04)?(05)?(06)?(07)?(08)?(09)?(10)?|-$";
    static let reg11 = "^(01)?(02)?(03)?(04)?(05)?(06)?(07)?(08)?(09)?(10)?(11)?|-$";
    static let reg11Comma = "^(01)?((,|\\b)02)?((,|\\b)03)?((,|\\b)04)?((,|\\b)05)?((,|\\b)06)?((,|\\b)07)?((,|\\b)08)?((,|\\b)09)?((,|\\b)10)?((,|\\b)11)?$";
    /** 三星和值 */
    static let SXHZ = [ 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 63, 69, 73, 75, 75, 73, 69, 63, 55, 45, 36, 28, 21, 15, 10, 6, 3, 1 ];
    /** 二星和值 */
    static let EXHZ = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 ];
    /** 北京赛车冠亚和值 */
    static let BJSCHZ = [ 0, 0, 0, 2, 2, 4, 4, 6, 6, 8, 8, 10, 8, 8, 6, 6, 4, 4, 2, 2 ];
    /** 快3和值 */
    static let K3HZ = [ 0, 0, 0, 1, 3, 6, 10, 15, 21, 25, 27, 27, 25, 21, 15, 10, 6, 3, 1 ];

    public static func calc(lotType:Int,playCode:String,haoMa:String) -> Int{
        switch lotType{
        case 1,2,51,52:
            return getSscZhushu(subCode: playCode, haoMa: haoMa)
        case 3,53:// pk10
            return getBjscZhushu(subCode: playCode, haoMa: haoMa)
        case 4,54:// 排列三
            return getPL3ZhuShu(playCode: playCode, haoMa: haoMa)
        case 5,55:// 11选5
            return get11x5Zhushu(playCode: playCode, haoMa: haoMa)
        case 7,57:// PC蛋蛋
            return getPceggZhuShu(subCode: playCode, hasMa: haoMa)
        case 58,100:// 快三
            return getK3ZhuShu(playCode: playCode, haoMa: haoMa)
        default:
            return 0
        }
    }
    
    static func daXiaoDanShuang(haoMa:String,count:Int) -> Int{
        var zs = 0;
        let split = haoMa.components(separatedBy: ",")
        if (split.count == count) {
            zs = 1;
            for str in split{
                let regex = "^大?小?单?双?$"// 验证投注号码
                let isMatch = isMatchRegex(text: str, regex: regex)
                if !isMatch{
                    return 0
                }
                zs = zs*str.count;
            }
        }
        return zs;
    }
    
    static func getK3ZhuShu(playCode:String,haoMa:String)->Int{
        switch playCode {
        case hz:
            var zs = 0;
            let split = haoMa.components(separatedBy: ",")
            for str in split{
                let s = Int(str)
                if let sv = s{
                    if sv < 3 || sv > 18{
                        return 0
                    }
                    zs += K3HZ[sv]
                }
            }
            return zs
        case dxds:
            if isMatchRegex(text: haoMa, regex: "^大?小?单?双?$"){
                return haoMa.count
            }
            return 0
        case sthtx:
            if haoMa == "三同号通选"{
                return 1
            }
            return 0
        case sthdx:
            let haoMas = haoMa.components(separatedBy: ",")
            var zs = 0
            for hm in haoMas{
                if isMatchRegex(text: hm, regex: "^([1-6])\\1\\1$"){
                    zs = zs + 1
                }else{
                    return 0
                }
            }
            return zs
        case sbtx://三不同号
            let haoMas = haoMa.components(separatedBy: ",")
            var set:Set<Int> = Set<Int>()
            var zs = 0
            for hm in haoMas{
                let h = Int(hm)
                if let hv = h{
                    if hv<1||hv>6{
                        return 0
                    }
                    set.insert(hv)
                }
            }
            zs = set.count
            if zs<3{
                return 0
            }
            return zs*(zs-1)*(zs-2)/6
        case slhtx://三连号通选
            if haoMa == "三连号通选"{
                return 1
            }
            return 0
        case ethfx://二同号复选
            let haoMas = haoMa.components(separatedBy: ",")
            var zs = 0
            for hm in haoMas{
                if isMatchRegex(text: hm, regex: "^([1-6])\\1$"){
                    zs = zs + 1
                }
            }
            return zs
        case ethdx://二同号单选
            let haoMas = haoMa.components(separatedBy: ",")
            if !isMatchRegex(text: haoMas[0], regex: "^(([1-6])\\2){1,6}$") || !isMatchRegex(text: haoMas[1], regex: "^1?2?3?4?5?6?$"){
                return 0
            }
            return haoMas[0].count*haoMas[1].count/2
        case ebth://二不同号
            let haoMas = haoMa.components(separatedBy: ",")
            var zs = 0
            for hm in haoMas{
                if isMatchRegex(text: hm, regex: "^[1-6]$"){
                    zs = zs + 1
                }
            }
            if zs < 2{
                return 0
            }
            return zs*(zs-1)/2
        default:
            return 0
        }
    }
    
    /**
     * PC蛋蛋计算注数
     *
     * @param playTypeCode
     * @param haoma
     * @return
     */
    static func getPceggZhuShu(subCode:String,hasMa:String)->Int{
        if isEmptyString(str: hasMa){
            return 0
        }
        switch subCode {
        case hz:
            var zs = 0
            let split = hasMa.components(separatedBy: ",")
            for h in split{
                let s = Int(h)
                if let sv = s{
                    if sv<0 || sv>27{
                        return 0
                    }
                    zs += SXHZ[sv]
                }
            }
            return zs
        case dxds:
            if isMatchRegex(text: hasMa, regex: "^大?小?单?双?$"){
                return hasMa.count
            }
            return 0
        case q2zx_fs,h2zx_fs:// 前二复式,后二复式
            return one09By2Or3Nums(haoMa: hasMa, balls: 2)
        case sxfs:// 三星复式
            return one09By2Or3Nums(haoMa: hasMa, balls: 3)
        case q2zx,h2zx:// 前二组选,后二组选
            return one09ZuHe(haoMa: hasMa, step: 2)
        case sxzx:// 三星组选
            return one09ZuHe6(haoMa: hasMa)
        case bdw_pcegg:
            return one09DanZhu(haoMa: hasMa)
        case dwd:
            return dwdFunc(haoMa: hasMa, length: 3)
        case h2zx_ds,q2zx_ds:
            return danShi(haoMa: hasMa, pattern: "(\\d\\d;)*\\d\\d")
        case sxds:
            return danShi(haoMa: hasMa, pattern: "(\\d\\d\\d;)*\\d\\d\\d")
        default:
            return 0;
        }
    }
    
    static func one09DanZhu(haoMa:String)->Int{
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        for hm in split{
            if !isMatchRegex(text: hm, regex: reg09){
                return 0
            }
            if hm != "-"{
                zs += hm.count
            }
        }
        return zs
    }
    
    static func dwdFunc(haoMa:String,length:Int)->Int{
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        if split.count != length{
            return zs
        }
        for hm in split{
            if !isMatchRegex(text: hm, regex: reg09){
                return 0
            }
            if hm != "-"{
                zs += hm.count
            }
        }
        return zs
    }
    
    static func towNum2XFuShi(haoMa:String,reg:String)->Int{
        let split = haoMa.components(separatedBy: ",")
        if split.count != 2{
            return 0
        }
        for hm in split{
            if !isMatchRegex(text: hm, regex: reg){
                return 0
            }
        }
        let one = splitWithTowChar(char:split[0])
        let two = splitWithTowChar(char:split[1])
        var zs = one.count * two.count
        zs -= arrayIntersection(one: one, two: two)
        return zs
    }
    
    /** 号码为两位的投注 三星复式算法 */
    static func towNum3XFuShi(haoMa:String,reg:String)->Int{
        let split = haoMa.components(separatedBy: ",")
        if split.count != 3{
            return 0
        }
        for hm in split{
            if !isMatchRegex(text: hm, regex: reg){
                return 0
            }
        }
        let one = splitWithTowChar(char:split[0])
        let two = splitWithTowChar(char:split[1])
        let three = splitWithTowChar(char:split[2])
        var zs = one.count * two.count * three.count
        zs -= three.count*arrayIntersection(one: one, two: two)
        zs -= one.count*arrayIntersection(one: three, two: two)
        zs -= two.count*arrayIntersection(one: three, two: one)
        zs += arrayIntersection(one: one, two: two, three: three)*2
        return zs
    }
    
    /**
     * 将字符串每两位截取
     *
     * @param str
     * @return
     */
    static func splitWithTowChar(char:String)->[String]{
        if !isEmptyString(str: char){
            var arr = [String](repeating:"", count:char.count/2)
            print("the char ==== \(char),count = \(char.count)")
            for index in 0...char.count/2-1{
                let ns3 = (char as NSString).substring(with: NSMakeRange(index*2, 2))
                print("ns3 === \(ns3)")
                arr[index] = ns3
            }
            return arr
        }
        return []
    }
    
    static func arrayIntersection(one:[String],two:[String])->Int{
        var set:Set<String> = Set<String>()
        for s in one{
            set.insert(s)
        }
        var i = 0
        for s in two{
            if set.contains(s){
                i = i + 1
            }
        }
        return i
    }
    
    static func arrayIntersection(one:[String],two:[String],three:[String])->Int{
        var set1:Set<String> = Set<String>()
        var set2:Set<String> = Set<String>()
        for s in one{
            set1.insert(s)
        }
        for s in two{
            set2.insert(s)
        }
        var i = 0
        for s in three{
            if set1.contains(s)&&set2.contains(s){
                i = i + 1
            }
        }
        return i
    }
    
    static func one09By2Or3Nums(haoMa:String,balls:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        if split.count == balls{
            zs = 1
            for hm in split{
                if !isMatchRegex(text: hm, regex: reg09){
                    return 0
                }
                zs *= hm.count
            }
        }
        return zs
    }
    
    /**
     * 11选5投注注数计算 s
     *
     * @param playCode
     * @param haoMa
     * @return
     */
    static func get11x5Zhushu(playCode:String,haoMa:String)->Int{
        switch playCode {
        case rxfs_rx1z1:
            return nXingZuXuan(nBall:1,haoMa:haoMa)
        case rxfs_rx2z2:
            return nXingZuXuan(nBall:2,haoMa:haoMa)
        case rxfs_rx3z3:
            return nXingZuXuan(nBall:3,haoMa:haoMa)
        case rxfs_rx4z4:
            return nXingZuXuan(nBall:4,haoMa:haoMa)
        case rxfs_rx5z5:
            return nXingZuXuan(nBall:5,haoMa:haoMa)
        case rxfs_rx6z5:
            return nXingZuXuan(nBall:6,haoMa:haoMa)
        case rxfs_rx7z5:
            return nXingZuXuan(nBall:7,haoMa:haoMa)
        case rxfs_rx8z5:
            return nXingZuXuan(nBall:8,haoMa:haoMa)
        case dwd:
            return towNumDWD(haoMa: haoMa, length: 5, reg: reg11)
        case bdw_q3,bdw_h3,bdw_z3:
            return buDingDan(haoMa: haoMa)
        case q2zx_fs,h2zx_fs:
            return towNum2XFuShi(haoMa: haoMa, reg: reg11)
        case h3zx_fs,q3zx_fs,z3zx_fs:
            return towNum3XFuShi(haoMa: haoMa, reg: reg11)
        case q2zx,h2zx:
            return nXingZuXuan(nBall: 2, haoMa: haoMa)
        case h3zx,q3zx,z3zx:
            return nXingZuXuan(nBall: 3, haoMa: haoMa)
        case q2zx_ds,h2zx_ds:
            return danShi(haoMa: haoMa, pattern: "(?!(\\d\\d),\\1)(?:0\\d|1[0,1]),(?:0\\d|1[0,1])")
        case q3zx_ds,z3zx_ds,h3zx_ds:
            return danShi(haoMa: haoMa, pattern: "(?!(?:\\d\\d,)*?(\\d\\d),(?:\\d\\d,)*?\\1(?:\\d\\d)*?)(?:0\\d|1[0,1]),(?:0\\d|1[0,1]),(?:0\\d|1[0,1])")
        default:
            return 0
        }
    }
    
    /** 不定胆 */
    // 不定蛋特殊处理
    static func buDingDan(haoMa:String)->Int{
        if !isMatchRegex(text: haoMa, regex: reg11Comma){
            return 0
        }
        return haoMa.components(separatedBy: ",").count
    }
    
    /** N星组选 */
    static func nXingZuXuan(nBall:Int,haoMa:String)->Int{
        if isMatchRegex(text: haoMa, regex: "(?:\\d\\d,)*?(\\d\\d),(?:\\d\\d,)*?\\1(?:\\d\\d)*?"){
            return 0
        }
        let reg = "(0[1-9]|10|11)(?:,(?:0[1-9]|10|11)){" + String.init(describing: (nBall - 1))   + ",}"
        if !isMatchRegex(text: haoMa, regex: reg){
            return 0
        }
        return comb(n: haoMa.components(separatedBy: ",").count, m: nBall)
    }
    
    /**
     * 计算组合个数
     *
     * @param n
     * @param m
     * @return
     */
    static func comb(n:Int,m:Int)->Int{
        if n<m{
            return 0
        }
        var n1 = 1
        var n2 = 1
        var i = n
        var j = 1
        while j<=m {
            n1 *= i
            i = i - 1
            n2 *= j
            j = j + 1
        }
        print("n1 = \(n1),n2=\(n2)")
        return n1/n2
    }
    
    
    /**
     * 排列3 福彩3D 投注注数计算
     *
     * @param playTypeCode
     * @param haoma
     * @return
     */
    static func getPL3ZhuShu(playCode:String,haoMa:String)->Int{
        switch playCode {
        case bdw_1m:
            return one09DanZhu(haoMa: haoMa)
        case dwd:
            return dwdFunc(haoMa: haoMa, length: 3)
        case dxds_q2,dxds_h2:
            return daXiaoDanShuang(haoMa: haoMa, count: 2)
        case q2zx_fs,h2zx_fs:
            return one09By2Or3Nums(haoMa: haoMa, balls: 2)
        case zhx_fs:
            return one09By2Or3Nums(haoMa: haoMa, balls: 3)
        case zhx_ds:
            return danShi(haoMa: haoMa, pattern: "(\\d\\d\\d;)*\\d\\d\\d")
        case h2zx_ds,q2zx_ds:
            return danShi(haoMa: haoMa, pattern: "(\\d\\d;)*\\d\\d")
        case em_q2zux,em_h2zux,bdw_2m:
            return one09ZuHe(haoMa: haoMa, step: 2)
        case zux_z3:
            return one09ZuHe(haoMa: haoMa, step: 1)
        case zux_z6:
            return one09ZuHe6(haoMa: haoMa)
        default:
            return 0
        }
    }
    
    /**
     * 北京赛车投注注数计算
     *
     * @param playTypeCode
     * @param haoma
     * @return
     */
    static func getBjscZhushu(subCode:String,haoMa:String)->Int{
        switch subCode {
        case gyhz:
            var zs = 0
            let split = haoMa.components(separatedBy: ",")
            for hm in split{
                let s = Int(hm)
                if let sv = s{
                    if (sv < 3 || sv > 19) {
                        return 0;
                    }
                    zs += BJSCHZ[sv];
                }
            }
            return zs
        case dxds:
            if isMatchRegex(text: haoMa, regex: "^大?小?单?双?$"){
                return haoMa.count
            }
            return 0
        case dwd_saiche:
            return towNumDWD(haoMa: haoMa, length: 10, reg: reg10)
        case q1zx_fs:
            if !isMatchRegex(text: haoMa, regex: reg10){
                return 0
            }
            return haoMa.count/2
        case q2zx_fs:
            return towNum2XFuShi(haoMa: haoMa, reg: reg10)
        case q3zx_fs:
            return towNum3XFuShi(haoMa:haoMa, reg:reg10);
        case longhu_yajun,longhu_gunjun,longhu_jijun:
            if !isMatchRegex(text: haoMa, regex: "^龙?虎?$"){
                return 0
            }
            return haoMa.count
        case q2zx_ds:
            return danShi(haoMa: haoMa, pattern: "(?!(\\d\\d),\\1)(?:0\\d|10),(?:0\\d|10)")
        case q3zx_ds:
            return danShi(haoMa: haoMa, pattern: "(?!(?:\\d\\d,)*?(\\d\\d),(?:\\d\\d,)*?\\1(?:\\d\\d)*?)(?:0\\d|10),(?:0\\d|10),(?:0\\d|10)")
        default:
            break
        }
        return 0
    }
    
    static func getSscZhushu(subCode:String,haoMa:String) -> Int {
        switch subCode {
        case dwd:
            return calcDwd(haoMa:haoMa, count:5);
        case bdw_h31m,bdw_q31m,bdw_z31m:
            return bdwOne(haoMa:haoMa);
        case h2zx_hz,q2zx_hz:
            return calcErXingHeZhi(haoMa: haoMa)
        case h3zux_zu3,q3zux_zu3,z3zux_zu3:
            return one09ZuHe(haoMa: haoMa, step: 1)
        case h3zux_zu6,q3zux_zu6,z3zux_zu6:
            return one09ZuHe6(haoMa: haoMa)
        //  复式
        case q2zx_fs,h2zx_fs:// 二复试
            return one09By2Or3Nums(haoMa:haoMa, balls:2);
        case q2zx_ds,h2zx_ds:// 二单试
            return danShi(haoMa:haoMa, pattern: "\\d\\d");
        case q3zx_fs,h3zx_fs,z3zx_fs:
            return one09By2Or3Nums(haoMa:haoMa, balls:3);
        case q3zx_ds,h3zx_ds,z3zx_ds:// 三单试
            return danShi(haoMa:haoMa, pattern: "\\d{3}");
        case q4zx_fs,h4zx_fs:
            return one09By2Or3Nums(haoMa:haoMa, balls:4);
        case q4zx_ds,h4zx_ds:
            return danShi(haoMa:haoMa, pattern: "\\d{4}");
        case wxzx_fs:
            return one09By2Or3Nums(haoMa:haoMa, balls:5);
        case wxzx_ds:
            return danShi(haoMa:haoMa, pattern: "\\d{5}");
        case rxwf_r2zx_fs:
            return renXuanFuShi(haoMa:haoMa, count:2);
        case rxwf_r3zx_fs:
            return renXuanFuShi(haoMa:haoMa, count:3);
        case rxwf_r4zx_fs:
            return renXuanFuShi(haoMa:haoMa, count:4);
        case rxwf_r3zux_zu3:
            return renXuanRen3Zu(haoMa:haoMa, balls:2);
        case rxwf_r3zux_zu6:
            return renXuanRen3Zu(haoMa:haoMa, balls:3);
        case dxds_h2,dxds_q2:
            return daXiaoDanShuang(haoMa: haoMa, count: 2)
        case dxds_h3,dxds_q3:
            return daXiaoDanShuang(haoMa:haoMa, count:3)
        case dxds_zh:
            return daXiaoDanShuang(haoMa:haoMa, count:1)
        case longhudou:
            if !isMatchRegex(text: haoMa, regex: "^龙?虎?$"){
                return 0
            }
            return haoMa.count
        case longhuhe:
            if haoMa != "和"{
                return 0
            }
            return 1
        case baozi,shunzi,duizi,zaliu,banshun:
            if !isMatchRegex(text: haoMa, regex: "^(前三)?(中三)?(后三)?$"){
                return 0
            }
            return haoMa.count / 2
        default:
            break
        }
        return 0
    }
    
    private static func renXuanRen3Zu(haoMa:String,balls:Int) -> Int{
        let haoMas = haoMa.components(separatedBy: "@")
        if haoMas.count != 2 || !isMatchRegex(text: haoMas[0], regex: "^(万)?((,|\\b)千)?((,|\\b)百)?((,|\\b)十)?(,个)?$") || !isMatchRegex(text: haoMas[1], regex: reg09Comma){
            return 0
        }
        
        var weiZhiLength = haoMas[0].components(separatedBy: ",").count
        if weiZhiLength < 3{
            return 0
        }
        
        let hms = haoMas[1].components(separatedBy: ",")
        if (hms.count < balls){
            return 0;
        }
        
        weiZhiLength = weiZhiLength * (weiZhiLength - 1) * (weiZhiLength - 2) / 6;
        var zhuShu = 1;
        switch balls {
        case 2:
            let len = hms.count - 2
            var i = hms.count
            while i > len {
                zhuShu *= i
                i = i - 1
            }
        default:
            var l = 1;
            for a in 0...balls-1{
                zhuShu *= hms.count - a
            }
            var a = balls
            while a > 0 {
                l *= a
                a = a - 1
            }
            zhuShu /= l;
        }
        return zhuShu * weiZhiLength;
    }
    
    static func danShi(haoMa:String,pattern:String) -> Int{
        let hms = haoMa.components(separatedBy: ";")
        for hm in hms{
            if !isMatchRegex(text: hm, regex: pattern){
                return 0
            }
        }
        return hms.count;
    }
    
    /**
     * 组选
     *
     * @param haoma
     * @return
     */
    static func one09ZuHe(haoMa:String,step:Int) -> Int{
        if !isMatchRegex(text: haoMa, regex: reg09Comma){
            return 0
        }
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        if split.count > 0{
            zs = split.count * (split.count - 1)/step
        }
        return zs
    }
    
    static func one09ZuHe6(haoMa:String) -> Int{
        if !isMatchRegex(text: haoMa, regex: reg09Comma){
            return 0
        }
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        if split.count > 1{
            zs = split.count * (split.count - 1) * (split.count - 2)/6
        }
        return zs
    }
    
    /** 号码为两位的投注 定位胆 */
    static func towNumDWD(haoMa:String,length:Int,reg:String)->Int{
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        if split.count != length{
            return 0
        }
        for item in split{
            let isMatch = isMatchRegex(text: item, regex: reg)
            if !isMatch{
                return 0
            }
            if item != "-"{
                zs += item.count/2;
            }
        }
        return zs
    }
    
    static func calcErXingHeZhi(haoMa:String) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: ",")
        for item in split{
            let s = Int(item)
            if let svalue = s{
                if svalue < 0 || svalue > 18{
                    return 0
                }
                zs += EXHZ[svalue]
            }
        }
        return zs
    }
    
    static func calcDwd(haoMa:String,count:Int)->Int{
        
        var zs = 0
        let hms = haoMa.components(separatedBy: ",")
        if hms.count != count{
            return zs
        }
        for hm in hms{
            let isMatch = isMatchRegex(text: hm, regex: reg09)
            if !isMatch{
                return 0
            }
            if hm != "-"{
                zs += hm.count;
            }
        }
        return zs
    }
    
    static func bdwOne(haoMa:String) -> Int{
        let isMatch = isMatchRegex(text: haoMa, regex: reg09Comma)
        if (!isMatch) {
            return 0;
        }
        return haoMa.components(separatedBy: ",").count;
    }
    
    /**
     * 任选复式
     *
     * @param haoMa
     * @param count
     *            任选球数
     * @return
     */
    static func renXuanFuShi(haoMa:String,count:Int) -> Int{
        let hms = haoMa.components(separatedBy: ",")
        if hms.count < count{
            return 0
        }
        var list = [Int]()
        for hm in hms{
            if !isMatchRegex(text: hm, regex: reg09){
                return 0
            }
            if hm != "-"{
                list.append(hm.count)
            }
        }
        if list.count < count{
            return 0
        }
        var result = [[Int]]()
        paiLie(result: &result, temp: [Int](), arr: list, set: Set<Int>(), m: count, start: 0)
        var all = 0
        if result.isEmpty{
            return all
        }
        for index1 in 0...result.count-1{
            var a = 1
            for index2 in 0...result[index1].count-1{
                a *= result[index1][index2]
            }
            all += a
        }
        print("the pailie all  = \(all)")
        return all
    }
    
    static func paiLie(result:inout [[Int]],temp:[Int],arr:[Int],set:Set<Int>,m:Int,start:Int) -> Void{
        if m == 0{
            result.append(temp)
            return
        }
        var iL2:Set<Int>
        for i in start...arr.count-1{
            iL2 = Set<Int>()
            iL2 = iL2.union(set)
            if !iL2.contains(i){
                var t1 = [Int]()
                t1 = t1 + temp
                t1.append(arr[i])
                iL2.insert(i)
                paiLie(result: &result, temp: t1, arr: arr, set: iL2, m: m-1, start: i)
            }
        }
    }
    
}
