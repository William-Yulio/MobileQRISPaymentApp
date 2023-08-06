//
//  PaymentViewModel.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 05/08/23.
//

import Foundation
import UIKit

class PaymentViewModel{
    
    var dataSource: Transaction
    var transactionPrice: String
    var bankName: String
    var merchantName: String
    var transactionId: String
    
    init(dataSource: Transaction){
        self.dataSource = dataSource
        self.bankName = dataSource.bankName
        self.merchantName = dataSource.merchantName
        self.transactionId = dataSource.transactionId
        self.transactionPrice = dataSource.transactionPrice
    }

}
