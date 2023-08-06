//
//  TransactionViewModel.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 06/08/23.
//

import Foundation
import UIKit
import CoreData

class TransactionViewModel{
    
    // fungsi tambah data
    func createTransaction(_ transactionPrice:String, _ bankName:String, _ merchantName:String, _ transactionId:String){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // refensi entity yang telah dibuat sebelumnya
        let transactionEntity = NSEntityDescription.entity(forEntityName: "TransactionData", in: managedContext)

        // entity body
        let insert = NSManagedObject(entity: transactionEntity!, insertInto: managedContext)
        
//        let calculatedvalue = currentBalance - transactionPrice
        insert.setValue(transactionPrice, forKey: "transactionPrice")
        insert.setValue(bankName, forKey: "bankName")
        insert.setValue(merchantName, forKey: "merchantName")
        insert.setValue(transactionId, forKey: "transactionId")
        
        do{
            // save data ke entity user core data
            try managedContext.save()
        }catch let err{
            print(err)
        }
        
    }
    
    // fungsi refrieve semua data
    func retrieveTransaction() -> [Transaction]{
        
        var transactions = [Transaction]()
        
        // referensi ke AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TransactionData")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ data in
                transactions.append(
                    Transaction(transactionPrice: data.value(forKey: "transactionPrice") as! String, bankName: data.value(forKey: "bankName") as! String, merchantName: data.value(forKey: "merchantName") as! String, transactionId: data.value(forKey: "transactionId") as! String)
                )
            }
        }catch let err{
            print(err)
        }
        
        return transactions
        
    }
    
    func createNewBalance(_ currentBalance: Int, _ balanceId: String){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // refensi entity yang telah dibuat sebelumnya
        let transactionEntity = NSEntityDescription.entity(forEntityName: "CurrentBalance", in: managedContext)

        // entity body
        let insert = NSManagedObject(entity: transactionEntity!, insertInto: managedContext)
        
        insert.setValue(currentBalance, forKey: "currentBalance")
        insert.setValue(balanceId, forKey: "balanceId")
        
        do{
            // save data ke entity user core data
            try managedContext.save()
        }catch let err{
            print(err)
        }
        
    }
    
    func retrieveCurrentBalance() -> Int{
        
        var currentBalance = 0
        
        // referensi ke AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentBalance")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ data in
                currentBalance = data.value(forKey: "currentBalance") as! Int
            }
        }catch let err{
            print(err)
        }
        
        return currentBalance
        
    }
    
    func retrieveCurrentBalanceId() -> String{
        
        var currentBalanceId = ""
        
        // referensi ke AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentBalance")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ data in
                currentBalanceId = data.value(forKey: "balanceId") as! String
            }
        }catch let err{
            print(err)
        }
        
        return currentBalanceId
        
    }

        // Function to update the value of currentBalance
    func updateCurrentBalance(newValue: Int, balanceId: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext


        let fetchRequest: NSFetchRequest<CurrentBalance> = CurrentBalance.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "balanceId = %@", balanceId)

        do {
            let results = try managedContext.fetch(fetchRequest)
            if let currentBalance = results.first {
                
            currentBalance.setValue(newValue, forKey: "currentBalance")

            // Save the changes
            try managedContext.save()
            }
        } catch let error as NSError {
            print("Error updating currentBalance: \(error), \(error.userInfo)")
        }
    }
    
}
