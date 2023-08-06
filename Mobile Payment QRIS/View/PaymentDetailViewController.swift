//
//  PaymentDetailViewController.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 05/08/23.
//

import UIKit

class PaymentDetailViewController: UIViewController {
    
    public let merchantLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var transactionIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let saldoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let headlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "TRANSFER KE"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let subheadlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "JUMLAH"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let confirmPaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Bayar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget( self, action: #selector(confirmPayment), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail Payment"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        setupLayout()
        configureData()
    }
    
    var paymentVM: PaymentViewModel
    var transactionViewModel: TransactionViewModel = TransactionViewModel()

    init(paymentVM: PaymentViewModel) {
        self.paymentVM = paymentVM
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupLayout(){
        
        view.addSubview(headlineLabel)
        view.addSubview(merchantLabel)
        view.addSubview(transactionIdLabel)
        view.addSubview(subheadlineLabel)
        view.addSubview(saldoValueLabel)
        view.addSubview(confirmPaymentButton)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            headlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headlineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            merchantLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            merchantLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 50),
            
            transactionIdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transactionIdLabel.topAnchor.constraint(equalTo: merchantLabel.bottomAnchor, constant: 10),
            
            subheadlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subheadlineLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            
            saldoValueLabel.topAnchor.constraint(equalTo: subheadlineLabel.bottomAnchor, constant: 20),
            saldoValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saldoValueLabel.heightAnchor.constraint(equalToConstant: 50),
            saldoValueLabel.widthAnchor.constraint(equalToConstant: 200),

            confirmPaymentButton.heightAnchor.constraint(equalToConstant: 60),
            confirmPaymentButton.widthAnchor.constraint(equalToConstant: 350),
            confirmPaymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            confirmPaymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    func configureData(){
        merchantLabel.text = paymentVM.merchantName + " (" + paymentVM.bankName + ")"
        saldoValueLabel.text = paymentVM.transactionPrice
        transactionIdLabel.text = paymentVM.transactionId
    }
    
    @objc func confirmPayment(_ sender: UIButton){
        transactionViewModel.createTransaction( paymentVM.transactionPrice, paymentVM.bankName, paymentVM.merchantName, paymentVM.transactionId)
        
        var calculateData = transactionViewModel.retrieveCurrentBalance() - (Int(paymentVM.transactionPrice) ?? 0)
        
        transactionViewModel.updateCurrentBalance(newValue: calculateData, balanceId: "26Jul")
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    


}
