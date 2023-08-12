//
//  MPSocketManager.swift
//  MarketPlace
//
//  Created by mac on 2023/3/28.
//

import UIKit
//import Reachability

enum SocketConnetVC : String{
    case All = "All"
case Home = "Home"
case Market = "Market"
case Contract = "Contract"
case C2C = "C2C"
case Wallet = "Wallet"
}

class MPSocketManager: NSObject {
    let disposeBag = DisposeBag()
//    let reachability = Reachability() //判断网络连接
    let queue = Queuer(name: "PMSocketManagerQueue", maxConcurrentOperationCount: 1, qualityOfService: .default)

    static let share: MPSocketManager  = {
        let share = MPSocketManager()
        return share
    }()

    var mainSocket : WebSocket?{
        didSet{
            if let mainSocket{
                mainSocket.delegate = self
                mainSocket.connect()
            }
        }
    }
    private override init() {
        super.init()
        
        self.codeTimer.schedule(deadline:  .now() , repeating: .seconds(1))
        self.codeTimer.setEventHandler(handler: {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.remainingCount -= 1
        }})
        self.codeTimer.resume()
        
        let token = Archive.getToken()
        let wsString = String(Environment.current.wsUrl.absoluteString) + token
        let request = URLRequest(url: URL(string: wsString)!)
        self.mainSocket = WebSocket(request: request)
    }
    
    
    var remainingCount = 0 {
        didSet{
            
            if remainingCount < 0 {
                MPSocketManager.share.socketReconnect(time: 0)
                remainingCount = 6
            }
//            print("remainingCount  ==== \(remainingCount)")
        }
    }
    
    
    func socketReconnect(time : TimeInterval = 5) {
        //判断网络情况，如果网络正常，可以执行重连
  //      if reachability.isReachable() {
            //设置重连次数，解决无限重连问题
  //          reConnectTime =  reConnectTime + 1
  //          if reConnectTime < 5 {
                //添加重连延时执行，防止某个时间段，全部执行
//                let time: TimeInterval = 5.0
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                    self.mainSocket?.disconnect()

//                    if !self.isConnected {
                    let token = Archive.getToken()
                    //        let token = "341d1c44-8cfe-4ea2-84e8-01c71bf477a2"
                    let wsString = String(Environment.current.wsUrl.absoluteString) + token
                    let request = URLRequest(url: URL(string: wsString)!)
                    self.mainSocket = WebSocket(request: request)
  //                      self.socket.disconnect()
  ////                      self.subscribe()
//                    }
  //                  if !self.isConneting{
  //                      self.isConneting = true
  //                  }
  //                  self.subscribe()
                }
  //          } else {
  //              //提示重连失败
  //          }
  //      } else {
  //          //提示无网络
  //      }
    }
      
      //socket主动断开，放在app进入后台时，数据进入缓存。app再进入前台，app出现卡死的情况
          func socketDisConnect() {
//              if self.isConnected {
                  self.mainSocket?.disconnect()
//              }
         
          }
//    private lazy var socket: WebSocket = {
//        
//        return socket
//    }()
    let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
    var isConnected:Bool = false{
        didSet {
            isConneting = false
            if isConnected{
                
                subscribe()
            }else{
                MPSocketManager.share.socketReconnect(time: 0)
            }
        }
    }

    var canContinue = true

//    var pubKlineDatas = PublishSubject<ContractKlineMode>() //用于返回数据
//    var pubPositionDatas = PublishSubject<ContractDepthModel>() //用于返回数据
//    var pubMarketDatas = PublishSubject<SocketMarketModel>() //用于返回数据
//    var pubOrderDatas = PublishSubject<ContractEntrustModel>() //用于返回数据
//    var pubMarkPriceDatas = PublishSubject<SocketMarkPriceModel>() //用于返回数据
//    var pubChatImDatas = PublishSubject<ChatMessage>() //用于返回聊天消息
//    var pubOTCOrderDatas = PublishSubject<C2cOrderModel>() //用于返回聊天消息
//    var pubHodingData =  PublishSubject<ContractHoldingModel>() //持仓
//    var pubNewTradeData =  PublishSubject<[ContractKlineCurrentTrade]>() //持仓
//
//    var pubPushNoticeDates = PublishSubject<SocketPushNoticeModel>()//站内消息通知
//    var pubAccountFlushData =  PublishSubject<ContractAsset>() //持仓
    var currentSymbol = ""
    var klineTime : SubTopic.KlineTime = .min1
    var isConneting = false
//
    var subscribeList : [String : Array<SubTopic>] = [:]
    var reConnectTime = 0 //设置重连次数
    var currentKline :SubTopic = .klineUpdate(symbol: "ethusdt", time: .min15)
//
//    let timmer = MPTimeManager()
}

extension MPSocketManager {
    
    
    func subscribe(key:SocketConnetVC? = nil) {
        if let key {
            
            if let subs = subscribeList[key.rawValue] {
                for topic in subs{
                    self.websocketSub(topic: topic , vc:key)
                }
            }
        }else{
            for (key , arr) in self.subscribeList {
                for topic in arr{
                    self.websocketSub(topic: topic , vc:SocketConnetVC.init(rawValue: key) ?? .All)
                }
            }
        }
    }
    
    func unsubscribe(key:SocketConnetVC) {
        if let subs = subscribeList[key.rawValue] {
            for topic in subs{
                self.websocketUnSub(topic: topic , vc :key  , delete: false)
            }
        }
    }
    
    func websocketSub(topic: SubTopic , vc : SocketConnetVC = .All){
return
        
        let dict = ["id":"1929929929292", "topic":topic.getRawStr(),"data":[String:String](),"cmd":"sub"] as [String : Any]
//        print("订阅信息   = = = ==  == == = = \(dict)")
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])

        guard let data , let str = String(data:data, encoding: String.Encoding.utf8) else {
         
            return
        }
        
        if topic.getRawStr().hasPrefix("kline.update") {
            
            self.websocketUnSubKline()
            self.currentKline = topic
        }
        DispatchQueue.main.async {
         
            let key = vc.rawValue
            if var arr = self.subscribeList[key]{
                if arr.firstIndex(of: topic) == nil{
                    arr.append(topic)
                    self.subscribeList[key] = arr
                }
            }else{
                var array : [SubTopic] = []
                array.append(topic)
                self.subscribeList[key] = array
            }
        }
        
        if !isConnected{

            if !isConneting{
                isConneting = true
                MPSocketManager.share.socketReconnect(time: 0)
            }
//                self.socket.connect()
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.websocketSub(topic: topic)
//            }
            return
        }
            print("订阅信息   = = = ==  == == = = \(str)")
            
            self.mainSocket?.write(string: str){ [weak self] in
                guard let self = self else {return}

                if let currentSymbol = topic.currentKlineSymbol {
                    self.currentSymbol = currentSymbol
                }
                if let time = topic.currentKlineTime {
                    self.klineTime = time
                }
            }
//        }
    }
    
    func websocketUnSubKline(){
        
        self.websocketUnSub(topic: self.currentKline , vc: .Contract)
    }
    
    func websocketUnSub(topic: SubTopic , vc : SocketConnetVC = .All , delete : Bool = true){
        if !isConnected{
            return
        }
        
        let dict = ["id":"1929929929292", "topic":topic.getRawStr(),"data":[String:String](),"cmd":"unsub"] as [String : Any]
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        if let data , let str = String(data:data, encoding: String.Encoding.utf8) {
            self.mainSocket?.write(string: str, completion: {
                print("unsub success === \(str)")
                                
                if var arr = self.subscribeList[vc.rawValue] , delete{
                    if let index = arr.firstIndex(of: topic){
                        arr.remove(at: index)
                    }
                    self.subscribeList[vc.rawValue] = arr
                }
            })
        }
    }
    
    
}

extension MPSocketManager: WebSocketDelegate{
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            queue.resume()
            reConnectTime = 0
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
//            self.mainSocket?.disconnect()
            isConnected = false
//            self.socket.
//            MPSocketManager.share.so
            print("websocket is disconnected: \(reason) with code: \(code)")
            
        case .text(let string):
            do {
//                isConnected = true
                let jsonData:Data = string.data(using: .utf8)!
                let dict = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                print("%@" , dict)
                   
//                self.timmer.cancelTimer()
                self.remainingCount = 6
                
                if let theDict = dict as? Dictionary<String , Any> {
                    
                    if let ping = theDict["ping"] as? NSNumber  {
                        
//                        print("ping========\(ping)")
                    }else if let topic = theDict["topic"] as? String{
                        print("%@" , topic)
                        
                        if topic.contains("kline") {
                            print("eeee")
                        }
                        let topppp =  SubTopic.klineUpdate(symbol: self.currentSymbol, time: self.klineTime).getRawStr()
                        
                        if topic.contains("kline.update") {    //k线
//                            if let data = theDict["data"] as? [String:Any],let model =  ContractKlineMode.deserialize(from: data)  {
//                                pubKlineDatas.onNext(model)
//                            }
                        }else if topic.contains("depth.update"){    //盘口更新 SocketPositionModel
//                            if let data = theDict["data"] as? [String:Any], let model =  ContractDepthModel.deserialize(from: data)  {
//                                pubPositionDatas.onNext(model)
//                            }
                        }
                        else if topic.contains("market_trade.update") {    //交易更新
//                            if let data = theDict["data"] as? [String:Any] , let model =  ContractKlineCurrentTradePushResult.deserialize(from: data)  {
//                                pubNewTradeData.onNext(model.details)
//                            }
                        }
                        else if topic.contains("market.update")  {    //价格更新
//                            if let data = theDict["data"] as? [String:Any] , let model =  SocketMarketModel.deserialize(from: data)  {
//                                pubMarketDatas.onNext(model)
//                            }
                        }else if topic.contains("order.update") {    //订单更新
//                            if let dict = theDict["data"] as? [String:Any] , let data = dict["param"] as? [String:Any]  , let model =  ContractEntrustModel.deserialize(from: data){
//                                    pubOrderDatas.onNext(model)
//                                    print(model)
//                            }
                        }else if topic.contains("user-usdt-contract-position") {    //持仓更新
//                            if let data = theDict["data"] as? [String:Any] , let model =  ContractHoldingModel.deserialize(from: data)  {
//                                pubHodingData.onNext(model)
//                            }
                        }else if topic.contains("contract.marked.price") {    //订单更新
//                            if let data = theDict["data"] as? [String:Any] , let model =  SocketMarkPriceModel.deserialize(from: data){
//
//                                pubMarkPriceDatas.onNext(model)
//                            }
                        }else if topic.contains("ex-order-otc-im-topic") {    //otc im
//                            if let data = theDict["data"] as? [String:Any] , let model =  ChatMessage.deserialize(from: data){
//                                pubChatImDatas.onNext(model)
//                            }
                        }else if topic.contains("ex-order-otc-update-topic") {    //otc 订单
//                            if let data = theDict["data"] as? [String:Any] , let model =  C2cOrderModel.deserialize(from: data){
//                                pubOTCOrderDatas.onNext(model)
//                            }
                        }else if topic.contains("usdt-contract-user-account-flush") {    //订单更新
//                            if let data = theDict["data"] as? [String:Any] , let model =  ContractAsset.deserialize(from: data){
//                                pubAccountFlushData.onNext(model)
//                            }
                        }else if topic.contains("user_station_letter_notice_push"){    //订单更新
//                            if let data = theDict["data"] as? [String:Any] , let model =  SocketPushNoticeModel.deserialize(from: data){
//                                pubPushNoticeDates.onNext(model)
//                            }
                        }
                    }
                }
            }
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(let data):
            do{
                let pingContent = String(data: data ?? Data(), encoding: String.Encoding.utf8)
                if((pingContent?.contains("type")) != nil){
                    print("ping包内容"+(pingContent ?? "空")+"")
                }
            }
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            print("ws error: \(String(describing: error))")
            isConnected = false
        }
    }
    
    //socket 重连逻辑
    
}

