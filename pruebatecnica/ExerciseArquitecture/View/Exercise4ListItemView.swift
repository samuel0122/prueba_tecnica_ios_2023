//
//  Exercise4ListItemView.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 16/2/24.
//

import UIKit

class Exercise4ListItemView: UIView {
    var imageView: UIImageView!
    var labelTitleView: UILabel!
    
    func configure(image: UIImage?, title: String) {
        imageView.image = image
        labelTitleView.text = title
    }
}
