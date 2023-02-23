//
//  IngredientTableViewCell.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 23.02.2023.
//

import UIKit
import SnapKit

class IngredientTableViewCell: UITableViewCell {

    private let nameLabel = CustomLabel(
        text: "nameLabel",
        textAlignment: .left,
        size: 16,
        color: .black,
        weight: .light
    )
    
    private let valueLabel = CustomLabel(
        text: "valueLabel",
        textAlignment: .center,
        size: 17,
        color: .black,
        weight: .light
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupProperts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView).inset(16)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(contentView).inset(16)
            make.leading.equalTo(nameLabel.snp.trailing)
        }
    }
    
    private func setupProperts() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func setupData(name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value
    }

}
