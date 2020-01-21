//
//  RecipeListViewModel.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/20.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

class RecipeListViewModel {
    
    private var recipes: [Recipe]? {
        didSet {
            guard let recs = recipes else { return }
            self.setupRecipes(with: recs)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool? = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private let dataServiceProvider: DataServiceProvider
    
    //MARK: - Closures for callback, since we are not using the ViewModel to the View.
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var recipeList: [Recipe] = [Recipe]()
    var onRecipeSelected: (Recipe) -> Void
    
    // MARK: - Constructor
    
    init(dataServiceProvider: DataServiceProvider = DataServiceProvider(),
         onRecipeSelected: @escaping (Recipe)->Void) {
        self.dataServiceProvider = dataServiceProvider
        self.onRecipeSelected = onRecipeSelected
    }
    
    // MARK: - Network call
    
    func fetchRecipes() {
        self.dataServiceProvider.fetchRecipes { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.error = nil
                self?.isLoading = false
                self?.recipes = recipes
            case .failure(let error):
                self?.error = error
                self?.isLoading = false
                return
            }
        }
    }
    
    // MARK:- UI Logic
    
    private func setupRecipes(with recipes: [Recipe]?) {
        //Update ViewModel
        if let dataList = recipes {
            self.recipeList = dataList
        }
    }
    
    /// To inform the view model that a Recipe was tapped.
    /// View model executes call back for Recipe selection from coordinator.
    func didSelectRecipe(at index: Int) {
        onRecipeSelected(self.recipeList[index])
    }
}

