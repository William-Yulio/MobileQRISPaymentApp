//
//  HomepageViewController.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 05/08/23.
//

import UIKit

class HomepageViewController: UIViewController {
    
    public let saldoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Saldo saat ini"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let saldoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goToScannerPageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scan QR", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToScannerPage), for: .touchUpInside)
        return button
    }()
    
    var transactionViewModel: TransactionViewModel = TransactionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "QRIS Payment"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Transaction History", style: .plain, target: self, action: #selector(goTohistoryPage))
        
        setupLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if transactionViewModel.retrieveCurrentBalanceId().isEmpty {
            transactionViewModel.createNewBalance(500000, "26Jul")
            saldoValueLabel.text = "Rp. " + String(transactionViewModel.retrieveCurrentBalance())
            
        }else{
            saldoValueLabel.text = "Rp. " + String(transactionViewModel.retrieveCurrentBalance())
        }

    }
    
    func setupLayout(){
        view.addSubview(saldoLabel)
        view.addSubview(saldoValueLabel)
        view.addSubview(goToScannerPageButton)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            saldoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saldoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            saldoValueLabel.topAnchor.constraint(equalTo: saldoLabel.bottomAnchor, constant: 20),
            saldoValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            goToScannerPageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToScannerPageButton.topAnchor.constraint(equalTo: saldoValueLabel.bottomAnchor, constant: 50),
            goToScannerPageButton.widthAnchor.constraint(equalToConstant: 100),
            goToScannerPageButton.heightAnchor.constraint(equalToConstant: 60),


        ])
        
    }
    
    @objc func goToScannerPage(_ sender: UIButton){
        let scannerVC = ScannerViewController()
        self.navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    @objc func goTohistoryPage(_ sender: UIButton){
        let historyVC = TransactionHistoryViewController()
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    

}
