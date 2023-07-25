//
//  DiffableCollectionViewController.swift
//  DiffableDataSource
//
//  Created by Viktor Golovach on 25.07.2023.
//

import UIKit

class DiffableCollectionViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //Data Source
    private var dataSource: UICollectionViewDiffableDataSource<Section, Fruit>!
    private var fruits = [Fruit]()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection View"
        initCollectionView()
        initDataSource()
        
        //to add plus button to navigation bar 
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAdd))
    }
    
    //MARK: - Methods
    @objc
    private func didTapAdd() {
        let actionSheet = UIAlertController(
            title: "Select Fruit",
            message: nil,
            preferredStyle: .actionSheet)
        
        //Just simulate some data
        for x in 0...100 {
            actionSheet.addAction(UIAlertAction(title: "Fruit \(x+1)", style: .default, handler: { [weak self] _ in
                //[weak self] -> To avoid retain cycle
                guard let self = self else {return}
                let fruit = Fruit(title: "Fruit \(x+1)")
                self.fruits.append(fruit)
                self.updateDataSource()
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    
    private func initCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    private func initDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, IndexPath, model -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: IndexPath) as? CollectionViewCell else {return UICollectionViewCell()}
                cell.titleLabel.text = model.title
                return cell
            })
    }
    
    private func updateDataSource() {
        var snapshoot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshoot.appendSections([.first])
        snapshoot.appendItems(fruits)
        self.dataSource.apply(snapshoot, animatingDifferences: true)
    }
    
    
}


extension DiffableCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let fruit = dataSource.itemIdentifier(for: indexPath) else {return}
        print(fruit.title)
        
    }
}
