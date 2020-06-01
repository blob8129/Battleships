//
//  FieldItemCell.swift
//  Battleships
//
//  Created by Andrey Volobuev on 01/06/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import UIKit
import BattleshipsEngine

final class FieldItemCell: UICollectionViewCell {

    static let reuseIdentifier = "FieldItemCell"

    private lazy var label: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        contentView.backgroundColor = .white
        contentView.addSubview(label)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: label.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }

    func configure(using place: Place) {
        switch place {
        case .empty:
            label.text = "e"
        case .ship:
            label.text = "s"
        case .hit:
            label.text = "h"
        case .miss:
            label.text = "m"
        }

    }
}
