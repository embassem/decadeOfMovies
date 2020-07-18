//
//  MoviesDetailsViewController.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class MoviesDetailsViewController: NiblessViewController {
    
    let viewModel: MoviesDetailsViewModel
    lazy var collectionFlow: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        //        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flow
    }()
    lazy var collectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        self.view.addSubview(collection)
        collection.fillToSuperview()
        collection.backgroundColor = .grayscale800
        return collection
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setImage(UIImage(named: "ic_back"), for: [])
        btn.addTarget(self, action: #selector(backButtonWasTapped), for: .touchUpInside)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let top: NSLayoutConstraint
        let leading: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            top = btn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8)
            leading = btn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        } else {
            top = btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8)
            leading = btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        }
        NSLayoutConstraint.activate([top, leading])
        
        return btn
    }()
    
    // MARK: - Methods
    public init(_ viewModel: MoviesDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        
        collectionView.register(nibWithCellClass: MovieDetailsHeaderCell.self)
        collectionView.register(nibWithCellClass: MovieDetailsInfoCell.self)
        collectionView.register(nibWithCellClass: MoviePhotoCell.self)
        
        view.backgroundColor = UIColor.background
        view.bringSubviewToFront(backButton)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: MoviesDetailsViewModel) {
        viewModel.state.observe(on: self) { [weak self] _ in self?.collectionView.reloadData() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError(with: $0) }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc
    func backButtonWasTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension MoviesDetailsViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
            case 0:
                let item = indexPath.item
                switch item {
                    case 0:
                        let cell = collectionView.dequeueReusableCell(
                            withClass: MovieDetailsHeaderCell.self,
                            for: indexPath)
                        cell.fill(with: viewModel.item(for: indexPath))
                        return cell
                    case 1:
                        let cell = collectionView.dequeueReusableCell(
                            withClass: MovieDetailsInfoCell.self,
                            for: indexPath)
                        cell.fill(with: viewModel.item(for: indexPath))
                        return cell
                    default: return UICollectionViewCell()
            }
            
            case 1:
                let cell = collectionView.dequeueReusableCell(
                    withClass: MoviePhotoCell.self,
                    for: indexPath)
                cell.fill(with: viewModel.photoItem(for: indexPath))
                return cell
            
            default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let space: CGFloat =
            (collectionFlow.minimumInteritemSpacing) +
            (collectionFlow.sectionInset.left) +
            (collectionFlow.sectionInset.right)
        
        switch (indexPath.section, indexPath.row) {
            case (0, 0):  return CGSize(width: collectionView.frame.size.width, height: 160)
            case (0, 1): return CGSize(width: collectionView.frame.size.width, height: 200)
            case (1, _): return CGSize(width: ((collectionView.frame.size.width - space) / 2), height: 250)
            default: return .zero
            
        }
    }
}
