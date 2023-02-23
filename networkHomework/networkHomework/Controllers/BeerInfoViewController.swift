//
//  BeerInfoViewController.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 23.02.2023.
//

import UIKit
import SnapKit

class BeerInfoViewController: UIViewController {
    
    private var beer: Beer?
    
    private let networkManager = NetworkManager()
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let firstBrewedLabel = CustomLabel(
        text: "firstBrewed",
        textAlignment: .left,
        size: 16,
        color: .black,
        weight: .regular
    )
    
    private let desriptionLabel = CustomLabel(
        text: "desriptionLabel",
        textAlignment: .left,
        size: 16,
        color: .black,
        weight: .light
    )
    
    private let foodPairingLabel = CustomLabel(
        text: "foodPairingLabel",
        textAlignment: .left,
        size: 16,
        color: .black,
        weight: .light
    )
    
    private let ingredientsLabel = CustomLabel(
        text: "Ingredients:",
        textAlignment: .left,
        size: 18,
        color: .black,
        weight: .light
    )
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifire)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .systemGray6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupHeightOfIngredientTableView()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.width.equalTo(scrollView)
        }
        
        contentView.addSubview(beerImageView)
        contentView.addSubview(desriptionLabel)
        contentView.addSubview(firstBrewedLabel)
        contentView.addSubview(foodPairingLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsTableView)

        beerImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(beerImageView.snp.width)
        }

        firstBrewedLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.top.equalTo(beerImageView.snp.bottom).offset(8)
        }

        desriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.top.equalTo(firstBrewedLabel.snp.bottom).offset(8)
        }

        foodPairingLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.top.equalTo(desriptionLabel.snp.bottom).offset(16)
        }

        ingredientsLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.top.equalTo(foodPairingLabel.snp.bottom).offset(16)
        }
        
        ingredientsTableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.top.equalTo(ingredientsLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(contentView).inset(16)
        }
    }
    
    func setupData(beer: Beer) {
        self.beer = beer
        
        title = beer.name
        
        desriptionLabel.text = "Desription: " + beer.description
        firstBrewedLabel.text = "First Brewed: " + beer.firstBrewed
        foodPairingLabel.text = "Food pairing with: " + beer.foodPairing.joined(separator: ", ")
        
        if let url = beer.imageURL {
            guard let imageURL = URL(string: url) else {return}
            networkManager.getImage(from: imageURL) { imageData in
                self.beerImageView.image = UIImage(data: imageData)
            }
        } else {
            self.beerImageView.image = UIImage(named: "noImage")
        }
        ingredientsTableView.reloadData()
    }
    
    private func setupHeightOfIngredientTableView() {
        let height = tableView(ingredientsTableView, cellForRowAt: IndexPath(row: 0, section: 0)).bounds.height
        var value: CGFloat =  0
        if let maltQty = beer?.ingredients.malt.count, let hopsQty = beer?.ingredients.hops.count {
            value = CGFloat(maltQty + hopsQty + 1)
        }
         
        print(height)
        print(value)
        
        var heightOfTable = value*height + CGFloat(10)*value
        print(heightOfTable)
        ingredientsTableView.snp.makeConstraints {
            $0.height.equalTo(heightOfTable)
        }
    }
    
}

extension BeerInfoViewController: UITableViewDelegate {

}

extension BeerInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch section {
        case 0:
            rows = beer?.ingredients.malt.count ?? 0
        case 1:
            rows = beer?.ingredients.hops.count ?? 0
        case 2:
            rows = 1
        default:
            rows = 0
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifire, for: indexPath) as! IngredientTableViewCell
        var name = ""
        var value = ""
        switch indexPath.section {
        case 0:
            name = beer?.ingredients.malt[indexPath.row].name ?? ""
            value = "\((beer?.ingredients.malt[indexPath.row].amount.value)!)"
        case 1:
            name = beer?.ingredients.hops[indexPath.row].name ?? ""
            value = "\((beer?.ingredients.hops[indexPath.row].amount.value)!)"
        case 2:
            name = beer?.ingredients.yeast ?? ""
        default:
            break
        }
        cell.setupData(name: name, value: value)
        return cell
    }
}
