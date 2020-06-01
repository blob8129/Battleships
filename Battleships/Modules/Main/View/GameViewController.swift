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

    private let gameInteractorInput: GameInteractorInput

    lazy var shipSelectorTitleLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Place your ship!"
        return lbl
    }(UILabel())

    private lazy var shipLengthSegmentedControl: UISegmentedControl = { sls in
        sls.translatesAutoresizingMaskIntoConstraints = false
        (1...5).forEach {
            sls.insertSegment(withTitle: "\($0)", at: $0, animated: false)
        }
        sls.addTarget(self,
                      action: #selector(shipLengthSelectorValueChangedAction),
                      for: .valueChanged)
        return sls
    }(UISegmentedControl())

    private lazy var directionsSegmentedControl: UISegmentedControl = { sls in
        sls.translatesAutoresizingMaskIntoConstraints = false
        ["←", "↑", "→", "↓"].enumerated().forEach { offset, arrow in
            sls.insertSegment(withTitle: arrow, at: offset, animated: false)
        }
        sls.addTarget(self,
                      action: #selector(directionSelectorValueChangedAction),
                      for: .valueChanged)
        return sls
    }(UISegmentedControl())

    @objc func shipLengthSelectorValueChangedAction(sender: UISegmentedControl) {
        gameInteractorInput.didSelectShip(at: sender.selectedSegmentIndex)
    }

    @objc func directionSelectorValueChangedAction(sender: UISegmentedControl) {
        gameInteractorInput.didSelectDirection(at: sender.selectedSegmentIndex)
    }

    init(gameInteractorInput: GameInteractorInput) {
        self.gameInteractorInput = gameInteractorInput
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        hideShipSelection()
        addAllSubviews()
    }

    private func hideShipSelection() {
        shipLengthSegmentedControl.isHidden = true
        directionsSegmentedControl.isHidden = true
        shipSelectorTitleLabel.isHidden = true
    }

    func addAllSubviews() {
        view.addSubview(collectionView)
        view.addSubview(shipSelectorTitleLabel)
        view.addSubview(shipLengthSegmentedControl)
        view.addSubview(directionsSegmentedControl)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                          constant: 64),
            collectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),

            shipSelectorTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            shipSelectorTitleLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            view.layoutMarginsGuide.rightAnchor.constraint(equalTo: shipSelectorTitleLabel.rightAnchor),

            shipLengthSegmentedControl.topAnchor.constraint(equalTo: shipSelectorTitleLabel.bottomAnchor,
                                                            constant: 8),
            shipLengthSegmentedControl.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            view.layoutMarginsGuide.rightAnchor.constraint(equalTo: shipLengthSegmentedControl.rightAnchor),

            directionsSegmentedControl.topAnchor.constraint(equalTo: shipLengthSegmentedControl.bottomAnchor),
            directionsSegmentedControl.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            view.layoutMarginsGuide.rightAnchor.constraint(equalTo: directionsSegmentedControl.rightAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: directionsSegmentedControl.bottomAnchor,
                                                             constant: 64),
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
        cell?.configure(using: gameInteractorInput.item(at: indexPath))
        return cell!
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 40) / 9
        return CGSize(width: width, height: width)
    }

    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameInteractorInput.didSelectFieldItem(at: indexPath)
    }
}

extension GameViewController: GameInteractorOutput{

    func reload() {
        hideShipSelection()
        shipLengthSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        directionsSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        collectionView.reloadData()
    }

    func renderShipLengthSelector(isEnabled: [Bool]) {
        shipSelectorTitleLabel.isHidden = false
        shipLengthSegmentedControl.isHidden = false
        isEnabled.enumerated().forEach { offset, isOn in
            shipLengthSegmentedControl.setEnabled(isOn, forSegmentAt: offset)
        }
    }

    func renderDirectionSelector(isEnabled: [Bool]) {
        directionsSegmentedControl.isHidden = false
        isEnabled.enumerated().forEach { offset, isOn in
            directionsSegmentedControl.setEnabled(isOn, forSegmentAt: offset)
        }
    }
}
