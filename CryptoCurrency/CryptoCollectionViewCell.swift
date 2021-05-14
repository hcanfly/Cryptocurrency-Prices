//
//  CryptoCollectionViewCell.swift
//  CryptoCurrency
//
//  Created by Gary Hanson on 5/10/21.
//

import UIKit


final class CryptoCollectionViewCell: UICollectionViewListCell {
    
    static let reuseIdentifer = "cryptoCollectionViewCellReuseIdentifier"

    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let iconImageView = UIImageView()
    let priceLabel = UILabel()
    let percentChangeLabel = UILabel()
    let volumeLabel = UILabel()
    let marketCapLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentChangeLabel)
        contentView.addSubview(volumeLabel)
        contentView.addSubview(marketCapLabel)
        
        priceLabel.textAlignment = .right
        percentChangeLabel.textAlignment = .right
        volumeLabel.textAlignment = .right
        marketCapLabel.textAlignment = .right
        
        nameLabel.font = nameLabel.font.withSize(18)
        symbolLabel.font = symbolLabel.font.withSize(18)
        priceLabel.font = priceLabel.font.withSize(17)
        percentChangeLabel.font = percentChangeLabel.font.withSize(17)
        volumeLabel.font = volumeLabel.font.withSize(17)
        marketCapLabel.font = marketCapLabel.font.withSize(17)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        percentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 40).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: 40).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 24).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 112).isActive = true
        
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0).isActive = true
        symbolLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -4).isActive = true
        symbolLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 24).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 90).isActive = true
        
        percentChangeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0).isActive = true
        percentChangeLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 0).isActive = true
        percentChangeLabel.bottomAnchor.constraint(equalTo: percentChangeLabel.topAnchor, constant: 24).isActive = true
        percentChangeLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 0).isActive = true
        
        volumeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        volumeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -110).isActive = true
        volumeLabel.bottomAnchor.constraint(equalTo: volumeLabel.topAnchor, constant: 24).isActive = true
        volumeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        marketCapLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 0).isActive = true
        marketCapLabel.leadingAnchor.constraint(equalTo: volumeLabel.leadingAnchor, constant: 0).isActive = true
        marketCapLabel.bottomAnchor.constraint(equalTo: marketCapLabel.topAnchor, constant: 24).isActive = true
        marketCapLabel.trailingAnchor.constraint(equalTo: volumeLabel.trailingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
