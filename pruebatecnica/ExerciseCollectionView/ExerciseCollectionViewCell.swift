//
//  ExerciseCollectionViewCell.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 15/2/24.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 8
    }

    func configure(with content: ExerciseCollectionViewModel.Content) {
        imageView.image = UIImage(named: content.imageName)
        labelView.text = content.title
    }
    
}
