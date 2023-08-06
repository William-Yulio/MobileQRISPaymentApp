//
//  TransactionHistoryViewController.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 06/08/23.
//

import UIKit
import CoreData

class TransactionHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TransactionHistoryTableViewCell.self, forCellReuseIdentifier: TransactionHistoryTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var transactionViewModel: TransactionViewModel = TransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Riwayat Transaksi"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupLayout()
    }
    

    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
    }
    
    func setupLayout(){
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if transactionViewModel.retrieveTransaction().count == 0 {
            return 1
        } else{
            return transactionViewModel.retrieveTransaction().count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionHistoryTableViewCell.identifier, for: indexPath) as? TransactionHistoryTableViewCell else {
            fatalError("The tableview couldn't dequeue a Custom Cell in ViewController")
        }
        
        if transactionViewModel.retrieveTransaction().count == 0{
            cell.merchantLabel.text = "No Data"
            cell.transactionPriceLabel.text = "No Data"
        }else{
            cell.merchantLabel.text = self.transactionViewModel.retrieveTransaction()[indexPath.row].merchantName
            cell.transactionPriceLabel.text = "Rp. " + self.transactionViewModel.retrieveTransaction()[indexPath.row].transactionPrice

        }
        
        return cell
    }

}
