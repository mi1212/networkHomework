//
//  BeersCollectionViewController.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 21.02.2023.
//

import UIKit
import SnapKit

class BeersCollectionViewController: UIViewController {
    
    var beers = [Beer]() {
        didSet{
            beersCollectionView.reloadData()
        }
    }
    
    private let networkManager = NetworkManager()
    
    private let beersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCell.identifire)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperts()
        setupLayout()
        networkManager.getBeerData { beers in
            self.beers = beers
        }
    }
    
    func setupProperts() {
        view.backgroundColor = .white
        title = "Beers Info"
        beersCollectionView.delegate = self
        beersCollectionView.dataSource = self
    }
    
    func setupLayout() {
        view.addSubview(beersCollectionView)
        
        beersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}

extension BeersCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifire, for: indexPath) as! BeerCollectionViewCell
        cell.setupData(beer: beers[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    
}

extension BeersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 8
        let height = view.frame.height/8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
}
