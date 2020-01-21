//
//  BaseCoordinator.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/20.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

final class BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        return configureRecipeListViewController()
    }
    
    //MARK: - Private methods
    
    /// - Returns: Instance of RecipeListViewController
    private func configureRecipeListViewController() -> RecipeListViewController {
        let viewModel = RecipeListViewModel(onRecipeSelected: { recipe in
            self.showRecipeDetails(for: recipe)
        })
        return RecipeListViewController(viewModel: viewModel)
    }

    /// - Returns: Instance of RecipeDetailViewController
    private func showRecipeDetails(for recipe: Recipe) {
        let viewModel = RecipeDetailViewModel(with: recipe)
        let viewController = RecipeDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
