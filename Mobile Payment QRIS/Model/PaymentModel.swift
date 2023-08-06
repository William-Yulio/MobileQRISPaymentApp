//
//  PaymentModel.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 05/08/23.
//

import Foundation

struct Balance{
    var currentBalance: Int
//    var transactionList: [Transaction]?
    var balanceId: String
    
    init(currentBalance: Int, balanceId: String) {
        self.currentBalance = currentBalance
        self.balanceId = balanceId
    }
}

struct Transaction{
    var transactionPrice: String
    var bankName: String
    var merchantName: String
    var transactionId: String
    
    init(transactionPrice: String, bankName: String, merchantName: String, transactionId: String) {
        self.transactionPrice = transactionPrice
        self.bankName = bankName
        self.merchantName = merchantName
        self.transactionId = transactionId
    }
}
