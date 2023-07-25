//
//  TableViewModel.swift
//  DiffableDataSource
//
//  Created by Viktor Golovach on 25.07.2023.
//

import Foundation

enum Section {
    case first
}

struct Fruit: Hashable {
    
    let id = UUID()
    let title: String
    
    //MARK: - Please note that we have to implement CodingKeys in order to add uniquness to Fruit element
    //MARK: - All elements in DiffableDataSource should be unique 
    private enum CodingKeys : String, CodingKey { case title }
}
