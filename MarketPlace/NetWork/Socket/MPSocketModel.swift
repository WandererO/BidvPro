//
//  MPSocketModel.swift
//  MarketPlace
//
//  Created by tank on 2023/4/4.
//

import UIKit

enum SubTopic :Equatable {
    ///topic: kline.update.{1}.{2}.{3} 占位符 1:市场类型现在默认是用u代表U本位 2:交易对 3:时间间隔
    /// k线更新    时间间隔有 1、3、5、15、30、60、120、240、360、480、720、1D、3D、1W
    case klineUpdate(marketType:String = "u", symbol:String ,time:KlineTime)
    ///topic: depth.update.{1}.{2} 占位符 1:市场类型现在默认是用u代表U本位 2:交易对
    /// 盘口更新
    case depthUpdate(marketType:String = "u", symbol:String)
    ///topic: price.update.{1}.{2} 占位符 1:市场类型现在默认是用u代表U本位 2:交易对
//    ///市场最新价格更新
//    case priceUpdate(marketType:String = "u", symbol:String)
    ///topic: market.update
    ///行情更新
    case marketUpdate
    ///topic: order.update
    ///订单（持仓）更新
    case orderUpdate
    ///usdt.contract.marked.price
    ///标记价
    case markPriceUpdate(marketType:String = "usdt",symbol:String)
    
    ///user-usdt-contract-position
    ///仓位
    case contractHoldingUpdate(symbol:String)

    case otcIm
    
    case otcOrder
    
    case accountFlush // USDT合约可用保证金实时刷新
    
    case pushNotice

    case newTrade(symbol:String)
    
    var currentKlineSymbol : String? {
        
        get{
            switch self {
            case let .klineUpdate(_,  symbol, _):
                return symbol
            case let .depthUpdate( _ ,symbol):
                return symbol
//            case let .priceUpdate(_,  symbol):
//                return symbol
            case let .markPriceUpdate(_ , symbol):
                return symbol
            case let .contractHoldingUpdate(symbol):
                return symbol
            case let .newTrade(symbol):
                return symbol

            default :
                return nil
            }
        }
    }
    
    var currentKlineTime: KlineTime? {
        
        get{
            switch self {
            case let .klineUpdate(_, _, time):
                return time
            default :
                return nil
            }
        }
    }

    
    func getRawStr() ->String{
        switch self {
        case let .klineUpdate(marketType,symbol,time):
            return "kline.update.\(marketType).\(symbol).\(time.rawValue)"
        case let .depthUpdate(marketType,symbol):
            return "depth.update.\(marketType).\(symbol)"
//        case let .priceUpdate(marketType,symbol):
//            return "price.update.\(marketType).\(symbol)"
        case .marketUpdate:
            return "market.update"
        case .orderUpdate:
            return "order.update"
        case let .contractHoldingUpdate(symbol):
            return "user-usdt-contract-position-\(symbol)"
        case let .markPriceUpdate(marketType,symbol):
            return "\(marketType).contract.marked.price.\(symbol)"
        case  .otcIm:
            return "ex-order-otc-im-topic"
        case .otcOrder :
            return "ex-order-otc-update-topic"
        case .accountFlush:
            return "usdt-contract-user-account-flush"
        case .pushNotice:
            return "user_station_letter_notice_push"
        case let .newTrade(symbol):
            return "market_trade.update.u.\(symbol)"
        }
    }
    
    func getTopic() ->String{
        switch self {
        case  .klineUpdate:
            return "kline.update"
        case .depthUpdate:
            return "depth.update"
        case .marketUpdate:
            return "market.update"
        case .orderUpdate:
            return "order.update"
        case .contractHoldingUpdate:
            return "user-usdt-contract-position"
        case .markPriceUpdate:
            return "contract.marked.price"
        case  .otcIm:
            return "ex-order-otc-im-topic"
        case .otcOrder :
            return "ex-order-otc-update-topic"
        case .accountFlush:
            return "usdt-contract-user-account-flush"
        case .pushNotice:
            return "user_station_letter_notice_push"
        case .newTrade:
            return "market_trade.update"
        }
    }

    
    enum KlineTime:String {
        
        case min1 = "1"
        case min3 = "3"
        case min5 = "5"
        case min15 = "15"
        case min30 = "30"
        case hour1 = "60"
        case hour2 = "120"
        case hour4 = "240"
        case hour6 = "360"
//        case hour8 = "480"
        case hour12 = "720"
        case day1 = "1D"
        case day3 = "3D"
        case week1 = "1W"
        case month = "1M"
        case line = "line"
        
        func getValue() ->String{
            
            switch self{
            case .min1:
                return "1分"
            case .min3:
                return "3分"
            case .min5:
                return "5分"
            case .min15:
                return "15分"
            case .min30:
                return "30分"
            case .hour1:
                return "1小时"
            case .hour2:
                return "2小时"
            case .hour4:
                return "4小时"
            case .hour6:
                return "6小时"
            case .hour12:
                return "12小时"
            case .day1:
                return "1日"
            case .day3:
                return "3日"
            case .week1:
                return "周"
            case .month:
                return "月"
            case .line:
                return "分时"
            }
        }
    }
    
    
}

/////k线模型
//class SocketKlineModel: BaseModel {
//
//    var volume:Double = 0.0
//    var symbol:String = ""
//    var low:Double = 0.0
//    var time:Double = 0.0
//    var close:Double = 0.0
//    var hige:Double = 0.0
//}
/*
 {
    "cmd": "real",
    "data": {
        "param": {
            "symbol": "BTC/USDT",
            "ask": [
                {
                    "price": 12735.1,
                    "num": 40.00,
                    "sum": 509404.000
                }
            ],
            "bid": []
        },
        "type": "depth.update"
    },
    "pushMessageType": "1",
    "responseCode": 1,
    "time": 1680492686746,
    "topic": "depth.update.u.btcusdt"
 }
 */
///盘口模型
class SocketPositionModel: BaseModel {
    
    var symbol:String = ""
    var bid :[positionModel] = []
    var ask :[positionModel] = []
    
    class positionModel : BaseModel{
        var price:String = ""
        var num:String = ""
        var sum:String = ""
    }
}
/*
 "param": {
          "symbol": "BTC/USDT",
          "lowPrice": 999999999,
          "change": 0,
          "higePrice": 0,
          "turnoverOf24h": 0,
          "volOf24h": 0,
          "lastPrice": 0
      },
      "type": "price.update"
 */
///市场价格更新
class SocketPriceModel: BaseModel {
    
    var symbol:String = ""
    var lowPrice:String = ""
    var change:String = ""
    var higePrice:String = ""
    var turnoverOf24h:String = ""
    var volOf24h:String = ""
    var lastPrice:String = ""
}

///行情更新
class SocketMarketModel: BaseModel {
    
    var symbol:String = ""
    var lowPrice:String = ""
    var change:String = ""
    var higePrice:String = ""
    var turnoverOf24h:String = ""
    var volOf24h:String = ""
    var turnoverOf24hWithUnit:String = ""
    var volOf24hWithUnit:String = ""
    var lastPrice:String = ""
    var ratePrice:String = ""
}
/////订单更新
//class SocketOrderModel: BaseModel {
//    var userId:String = ""
//    var dealType:String = ""
//    var symbolKey:String = ""
//    var coinMarket:String = ""
//    var trustOrderNo:String = ""
//    var orderStatus:String = ""
//    var trustNumber:String = ""
//    var trustPrice:String = ""
//    var currentDealNumber:String = ""
//    var consumerAllNumber:String = ""
//    var remainingNumber:String = ""
//    var dealPrice:String = ""
//    var createTime:String = ""
//    var dealTime:String = ""
//
//}

///标记价更新
class SocketMarkPriceModel: BaseModel {
    var coinId:String = ""
    var markedPrice:String = ""
}

///站内消息通知
class SocketPushNoticeModel : BaseModel {
    var messageKey:String = ""
    var title : String = ""
    var content:String = ""
}
