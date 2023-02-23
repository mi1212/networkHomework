//
//  BeerCollectionViewCell.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 21.02.2023.
//

import UIKit
import SnapKit

class BeerCollectionViewCell: UICollectionViewCell {

    var indexPath = IndexPath(row: 0, section: 0)
    
    private let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel = CustomLabel(
        text: "nameLabel",
        textAlignment: .left,
        size: 16,
        color: .black,
        weight: .regular
    )
    
    private let desriptionLabel = CustomLabel(
        text: "desriptionLabel",
        textAlignment: .left,
        size: 14,
        color: .black,
        weight: .light
    )
    
    private let networkManager = NetworkManager()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        setupProperts()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(beerImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(desriptionLabel)
        
        beerImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(contentView).inset(8)
            $0.width.equalTo(beerImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(8)
            $0.top.trailing.equalTo(contentView).inset(8)
        }
        
        desriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(8)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.bottom.trailing.equalTo(contentView).inset(8)
        }
        
    }
    
    private func setupProperts() {
        contentView.backgroundColor = .systemGray6
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }
    
    func setupData(beer: Beer, indexPath: IndexPath) {
        nameLabel.text = beer.name
        desriptionLabel.text = beer.description
        let imageURL = URL(string: beer.imageURL)
        downloadImage(from: imageURL!)
        
        self.indexPath = indexPath
    }
    
    func downloadImage(from url: URL) {
        networkManager.getImage(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.beerImageView.image = UIImage(data: data)
            }
        }
    }
    
}
