//
//  AccountChangeDetailController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

//体育注单详情
class AccountChangeDetailController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    var datas:[String] = []
    var changeJson = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.title = "帐变详情"
        self.title = "帐变详情"
        fillDataByJson()
    }
    
    func fillDataByJson() -> Void {
        if isEmptyString(str: self.changeJson){
            return
        }
        let result = JSONDeserializer<AccountRecord>.deserializeFrom(json: self.changeJson)
        if let value = result{
            self.datas.removeAll()
            self.datas.append(String.init(format: "订单号：%@", value.orderno))
            self.datas.append(String.init(format: "会员名：%@", value.account))
            self.datas.append(String.init(format: "变动前金额：%.2f元", value.moneyBefore))
            self.datas.append(String.init(format: "变动后金额：%.2f元", value.moneyAfter))
            self.datas.append(String.init(format: "变动金额：%.2f元", (value.moneyAfter - value.moneyBefore)))
            self.datas.append(String.init(format: "交易类型：%@", convertAccountChangeTypeToString(type: value.type)))
            self.datas.append(String.init(format: "日期：%@", value.timeStr))
            self.datas.append(String.init(format: "变动情况：%@", value.remark))
            
            self.tableView.reloadData()
        }
    }
    
    func convertAccountChangeTypeToString(type:Int) -> String {
        return getType(code:type)
    }
    
    //var moneyType = {1:"人工加款",2:"人工扣款",130:"彩票投注",3:"在线取款失败",131:"彩票派奖",
    // 4:"在线取款",132:"彩票撤单",5:"在线支付",133:"彩票派奖回滚",6:"快速入款",134:"参与彩票合买",
    // 7:"一般入款",135:"彩票合买满员",136:"彩票合买失效",9:"反水加钱",201:"体育投注",137:"彩票合买撤单",
    // 10:"反水回滚",202:"体育派奖",138:"彩票合买截止",11:"代理反点加钱",203:"体育撤单",139:"彩票合买派奖",
    // 12:"代理反点回滚",204:"体育派奖回滚",140:"六合彩投注",13:"多级代理反点加钱",141:"六合彩派奖",
    // 14:"多级代理反点回滚",142:"六合彩派奖回滚",15:"三方额度转入系统额度",79:"注册赠送",143:"六合彩撤单",
    // 16:"系统额度转入三方额度",80:"存款赠送",17:"三方转账失败",18:"活动中奖",19:"现金兑换积分",20:"积分兑换现金",23:"系统接口加款"};
    func getType(code:Int) -> String {
        var name = "未知类型"
        switch code {
        case 1:
            name = "人工加款";
            break;
        case 2:
            name = "人工扣款";
            break;
        case 3:
            name = "在线取款失败";
            break;
        case 4:
            name = "在线取款";
            break;
        case 5:
            name = "在线支付";
            break;
        case 6:
            name = "快速入款";
            break;
        case 7:
            name = "一般入款";
            break;
        case 8:
            name = "体育投注";
            break;
        case 9:
            name = "二级代理反水加钱";
            break;
        case 10:
            name = "二级代理反水扣钱";
            break;
        case 11:
            name = "二级代理反点加钱";
            break;
        case 12:
            name = "二级代理反点扣钱";
            break;
        case 13:
            name = "多级代理反点加钱";
            break;
        case 14:
            name = "一多级代理反点扣钱";
            break;
        case 15:
            name = "三方额度转入系统额度";
            break;
        case 16:
            name = "系统额度转入三方额度";
            break;
        case 17:
            name = "三方转账失败";
            break;
        case 18:
            name = "活动中奖";
            break;
        case 19:
            name = "现金兑换积分";
            break;
        case 20:
            name = "积分兑换现金";
            break;
        case 23:
            name = "系统接口加款";
            break;
        case 79:
            name = "注册赠送";
            break;
        case 80:
            name = "存款赠送";
            break;
        case 130:
            name = "彩票投注";
            break;
        case 132:
            name = "彩票撤单";
            break;
        case 133:
            name = "彩票派奖回滚";
            break;
        case 140:
            name = "六合彩投注";
            break;
        case 141:
            name = "六合彩派奖";
            break;
        case 142:
            name = "六合彩派奖回滚";
            break;
        case 201:
            name = "体育投注";
            break;
        case 202:
            name = "体育派奖";
            break;
        case 203:
            name = "体育撤单";
            break;
        case 204:
            name = "体育派奖回滚";
        default:
            break
        }
        return name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.datas[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.textLabel?.textColor = UIColor.lightGray
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byWordWrapping
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.datas.isEmpty && indexPath.row == self.datas.count-1{
            return 66
        }
        return 44
    }
}
