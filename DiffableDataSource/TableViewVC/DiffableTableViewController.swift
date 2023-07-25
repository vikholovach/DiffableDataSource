//
//  DiffableTableViewController.swift
//  DiffableDataSource
//
//  Created by Viktor Golovach on 25.07.2023.
//

import UIKit

class DiffableTableViewController: UIViewController  {
    
    @IBOutlet private weak var tableView: UITableView!
    
    //Data source to use
    private var dataSource: UITableViewDiffableDataSource<Section, Fruit>!
    
    private var fruits = [Fruit]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initDataSource()
        title = "Table View"
        
        //to add plus button to navigation bar 
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(didTapAdd))
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
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshot.appendSections([.first])
        snapshot.appendItems(fruits)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func initTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
    }
    
    private func initDataSource() {
        dataSource = UITableViewDiffableDataSource(
            tableView: self.tableView,
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = model.title
                return cell
            })
    }
    
    
    
}

//MARK: - TableViewDelegate
extension DiffableTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fruit = dataSource.itemIdentifier(for: indexPath) else {return}
        print(fruit.title)
    }
}
