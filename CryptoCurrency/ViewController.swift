//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by Gary Hanson on 5/8/21.
//

import UIKit


fileprivate extension Selector {
    static let handleRefreshButtonTapped = #selector(ViewController.handleRefreshTapped)
}

final class ViewController: UICollectionViewController {
    private let viewModel = CryptoViewModel.shared
    private var dataSource: UICollectionViewDiffableDataSource<Section, CryptoData>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, CryptoData>!
    private var downloadinProgress = false
    private var sectionHeaderKind = "sectionHeaderKind"
    
    enum Section {
        case main
    }
    
    private let cellRegistration = UICollectionView.CellRegistration<CryptoCollectionViewCell, CryptoData> { (cell, indexPath, item) in

        cell.nameLabel.text = item.name
        cell.symbolLabel.text = item.symbol
        cell.priceLabel.text = item.price()
        cell.percentChangeLabel.text = item.percentChange()
        if item.percent_change() < 0.0 {
            cell.percentChangeLabel.textColor = .red
        } else {
            cell.percentChangeLabel.textColor = .green
        }
        cell.volumeLabel.text = item.volume()
        cell.marketCapLabel.text = item.marketCap()
        cell.iconImageView.image = UIImage(named: item.name)
        cell.iconImageView.contentMode = .scaleToFill
        cell.iconImageView.clipsToBounds = true
    }
    
    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(56))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(48))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.register(CryptoCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CryptoCollectionViewHeader.reuseIdentifer)
        
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Crypto Currencies"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: .handleRefreshButtonTapped)

        collectionView.collectionViewLayout = self.createBasicListLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        dataSource = UICollectionViewDiffableDataSource<Section, CryptoData>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: CryptoData) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CryptoCollectionViewHeader.reuseIdentifer, for: indexPath) as? CryptoCollectionViewHeader else {
                return nil
            }

            return sectionHeader
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
        ])
        
        viewModel.delegate = self
        viewModel.loadData()
    }
    
    @objc func handleRefreshTapped() {
        guard downloadinProgress == false else {
            return
        }

        downloadinProgress = true
        viewModel.loadData()
    }
}

extension ViewController: DataAction {
    
    func dataChanged() {
        self.snapshot = NSDiffableDataSourceSnapshot<Section, CryptoData>()
        self.snapshot.appendSections([.main])
        self.snapshot.appendItems(self.viewModel.data, toSection: .main)

        self.dataSource.apply(self.snapshot, animatingDifferences: false)
        downloadinProgress = false
    }
}
