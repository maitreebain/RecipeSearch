//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Maitree Bain on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    func configureCell(for recipe: Recipe) {
        recipeLabel.text = recipe.label
        
        //set image for recipe
        recipeImageView.getImage(with: recipe.image) { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
                DispatchQueue.main.async {
                    self?.recipeImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.recipeImageView.image = image
                }
            }
        }
    }

}
