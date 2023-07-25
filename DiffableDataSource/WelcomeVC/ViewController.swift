//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Viktor Golovach on 25.07.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            //tableView
            self.navigationController?.pushViewController(DiffableTableViewController(), animated: true)
        default:
            return
        }
        
    }
    
}

