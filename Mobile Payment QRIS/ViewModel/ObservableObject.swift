//
//  ObservableObject.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 05/08/23.
//

import Foundation
import UIKit

class ObservableObject<T>{
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping(T?) -> Void){
        listener(value)
        self.listener = listener
    }
}
