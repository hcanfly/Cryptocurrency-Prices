//
//  CryptoCollectionViewHeader.swift
//  CryptoCurrency
//
//  Created by Gary Hanson on 5/12/21.
//

import UIKit


final class CryptoCollectionViewHeader: UICollectionReusableView {
    
    static let reuseIdentifer = "sectionHeaderReuseIdentifier"

    let priceLabel = UILabel()
    let percentChangeLabel = UILabel()
    let volumeLabel = UILabel()
    let marketCapLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemGray4
        
        addSubview(priceLabel)
        addSubview(percentChangeLabel)
        addSubview(volumeLabel)
        addSubview(marketCapLabel)
        
        priceLabel.textAlignment = .center
        percentChangeLabel.textAlignment = .center
        volumeLabel.textAlignment = .center
        marketCapLabel.textAlignment = .center
        
        priceLabel.font = priceLabel.font.withSize(16)
        percentChangeLabel.font = percentChangeLabel.font.withSize(16)
        volumeLabel.font = volumeLabel.font.withSize(16)
        marketCapLabel.font = marketCapLabel.font.withSize(16)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        percentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.text = "Price"
        percentChangeLabel.text = "% Change"
        volumeLabel.text = "Volume"
        marketCapLabel.text = "Mkt. Cap"
        
        priceLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: -7).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 170).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 24).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 90).isActive = true
        
        percentChangeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -2).isActive = true
        percentChangeLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 0).isActive = true
        percentChangeLabel.bottomAnchor.constraint(equalTo: percentChangeLabel.topAnchor, constant: 24).isActive = true
        percentChangeLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 0).isActive = true
        
        volumeLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: -7).isActive = true
        volumeLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -80).isActive = true
        volumeLabel.bottomAnchor.constraint(equalTo: volumeLabel.topAnchor, constant: 24).isActive = true
        volumeLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
        
        marketCapLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: -2).isActive = true
        marketCapLabel.leadingAnchor.constraint(equalTo: volumeLabel.leadingAnchor, constant: 0).isActive = true
        marketCapLabel.bottomAnchor.constraint(equalTo: marketCapLabel.topAnchor, constant: 24).isActive = true
        marketCapLabel.trailingAnchor.constraint(equalTo: volumeLabel.trailingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
