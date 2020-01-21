//
//  RecipeDetailViewModel.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/21.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

class RecipeDetailViewModel {
    
    // MARK: - Private properties
    
    private let recipe: Recipe
    
    // MARK: - Initializer
    
    init(with recipe: Recipe) {
        self.recipe = recipe
    }
    
    // MARK: - Public properties
    
    var title: String? {
        return recipe.title
    }
    
    var description: String? {
        return recipe.description
    }
    
    var chefName: String? {
        return recipe.chefName
    }
    
    var tags: [String] {
        return recipe.tags
    }
    
    var imageUrl: URL? {
        return recipe.imageURL
    }
}
