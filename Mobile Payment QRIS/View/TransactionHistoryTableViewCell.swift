//
//  TransactionHistoryTableViewCell.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 06/08/23.
//

import UIKit

class TransactionHistoryTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    public let merchantLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let transactionPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupLayout(){
        self.contentView.addSubview(merchantLabel)
        self.contentView.addSubview(transactionPriceLabel)
        self.contentView.backgroundColor = .white

        NSLayoutConstraint.activate([
            
            merchantLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            merchantLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            transactionPriceLabel.topAnchor.constraint(equalTo: merchantLabel.bottomAnchor, constant: 20),
            transactionPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            contentView.heightAnchor.constraint(equalToConstant: 80),

        ])
    }

}
