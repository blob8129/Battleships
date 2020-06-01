//
//  ViewController.swift
//  Battleships
//
//  Created by Andrey Volobuev on 30/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import UIKit
import BattleshipsEngine

final class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private let engine = Engine()

    private lazy var flowLayout: UICollectionViewFlowLayout = { flow in
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        return flow
    }(UICollectionViewFlowLayout())

    private lazy var collectionView: UICollectionView = { clv in
        clv.translatesAutoresizingMaskIntoConstraints = false
        clv.register(FieldItemCell.self, forCellWithReuseIdentifier: FieldItemCell.reuseIdentifier)
        clv.backgroundColor = .white
        clv.dataSource = self
        clv.delegate = self
        return clv
    }(UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout))

    // MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAllSubviews()
    }

    func addAllSubviews() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.layoutMarginsGuide.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int { 9 }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int { 9 }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FieldItemCell.reuseIdentifier,
                                                      for: indexPath) as? FieldItemCell
        cell?.configure(using: engine[indexPath])
        return cell!
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 40) / 9
        return CGSize(width: width, height: width)
    }

    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
