//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    var recipe = [Recipe]() {
        didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    //TODO:
    //1. tableview
    //2. we need a recipes array
    // 3. on the recipes array we have a didSet{} to update the tableview
    // 4. in cell for row show the recipe's label
    // 5. RecipeSearchApi.fetchRecipes("christmas cookies") {...} accessing data to populate recipes array e.g christmas cookies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    
    
    func loadData() {
        RecipeSearchAPI.fetchRecipe(for: "sushi") { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let recipe):
                DispatchQueue.main.async {
                    self?.recipe = recipe
                }
            }
        }
    }
    
}

extension RecipeSearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        let selectedRecipe = recipe[indexPath.row]
        
        cell.textLabel?.text = selectedRecipe.label
        
        return cell
        
    }
}
