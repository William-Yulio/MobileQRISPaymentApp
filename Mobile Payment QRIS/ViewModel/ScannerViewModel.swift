//
//  ScannerViewModel.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 06/08/23.
//


import Foundation
import UIKit

class ScannerViewModel{

    func getDataFromQR(result: String) -> Transaction?{
        let dataArr = result.components(separatedBy: ".")
        let transaction = Transaction(transactionPrice: dataArr[3], bankName: dataArr[0], merchantName: dataArr[2], transactionId: dataArr[1])
        
        return transaction
    }

}
