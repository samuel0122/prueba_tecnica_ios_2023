//
//  Exercise4ListCellMapper.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 16/2/24.
//

import UIKit

class Exercise4ListCellMapper {
    func mapNews(news: [New]) -> [UIView] {
        news.map { createListCell(new: $0) }
    }
    
    private func createListCell(new: New) -> UIView {
        let listItem = Exercise4ListItemView()
        
        listItem.configure(image: UIImage(named: new.imageUrl), title: new.title)
        
        return listItem
    }
}
