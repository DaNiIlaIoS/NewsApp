//
//  TechnologyViewController.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 04.06.2024.
//

import UIKit
import SnapKit

final class TechnologyViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        collectionView.register(TechnologyCollectionViewCell.self, forCellWithReuseIdentifier: "TechnologyCollectionViewCell")
    }
    
    // MARK: - Methods
    
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TechnologyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCollectionViewCell", for: indexPath) as? TechnologyCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TechnologyViewController: UICollectionViewDelegate {
    
}

extension TechnologyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
