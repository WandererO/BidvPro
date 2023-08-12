//
//  CCTableViewCell.swift
//  MarketPlace
//
//  Created by WMT on 2022/7/21.
//

import UIKit

class ScanController: LXQRCodeViewController {

    let dataSubject = PublishSubject<String>()
    override func setCallBack(qrCode: String) {
           
           print("===\(qrCode)")
        dataSubject.onNext(qrCode)
        dataSubject.onCompleted()
        self.dismiss(animated: true, completion: nil)
          // UIApplication.shared.open(URL(string: qrCode)!, options: [:], completionHandler: nil)
       }
       
       
       override func setGoBack() {
           dataSubject.onError(NSError(domain: "", code: 0))
           self.dismiss(animated: true, completion: nil)
       }


}
