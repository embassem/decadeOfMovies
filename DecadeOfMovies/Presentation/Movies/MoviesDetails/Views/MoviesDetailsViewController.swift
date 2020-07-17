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
        return flow
    }()
    lazy var collectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        self.view.addSubview(collection)
        collection.fillToSuperview()
        collection.backgroundColor = .background
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
        
        collectionView.register(nibWithCellClass: MoviesDetailsHeaderCollectionViewCell.self)
        view.backgroundColor = UIColor.background
        view.bringSubviewToFront(backButton)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData {
            
        }
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
        
       let cell = collectionView.dequeueReusableCell(
        withClass: MoviesDetailsHeaderCollectionViewCell.self,
        for: indexPath)
        
     return cell
            
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
  
                if(indexPath.row == 0) {
                    return CGSize(width: collectionView.frame.size.width, height: 430)
                } else {
                    return CGSize(width: collectionView.frame.size.width, height: 90)
        }
        
    }
}
