//
//  RecipeLiteTests.swift
//  RecipeLiteTests
//
//  Created by Koushal, KumarAjitesh on 2020/01/20.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import XCTest
@testable import RecipeLite

class RecipeLiteTests: XCTestCase {
    
    private var viewModel: RecipeListViewModel?
    private var onRecipeSelectedCalled = false
    
    override func setUp() {
        onRecipeSelectedCalled = false
        let onRecipeSelected: (Recipe) -> () = { [weak self] response in
            self?.onRecipeSelectedCalled = true
        }
        viewModel = RecipeListViewModel(dataServiceProvider: MockDataServiceProvider(),
                                        onRecipeSelected: onRecipeSelected)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    /*
     // Test: For checking Tableview conforms to TableViewDatasource
     */
    func test_tableViewConformsToTableViewDataSourceProtocol() {
        let controller = RecipeListViewController(viewModel: viewModel!)
        XCTAssertTrue(controller.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:cellForRowAt:))))
    }
    
    /*
    // Test: For testing RecipeDetailViewModel
    */
    func test_RecipeDetailViewModel() {
        let recipe = Recipe.init(title: "Eat Fit",
                                 description: "Healthy Vegan Diet for a healthy soul and mind",
                                 chefName: "John AppleSeed",
                                 imageURL: URL(string: "https:images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg"),
                                 tags: ["healthy", "vegan"])
        
        let recipeDetailVM = RecipeDetailViewModel.init(with: recipe)
        
        XCTAssertEqual(recipe.title, recipeDetailVM.title)
        XCTAssertFalse(recipeDetailVM.imageUrl == nil)
    }
    
    /*
    // Test: For testing FetchRecipeList Success
    */
    func test_FetchRecipeListSuccessful() {
        let expectation = self.expectation(description: "Fetch")
        expectation.fulfill()
        MockDataServiceProvider.shouldSucceed = true
        viewModel?.fetchRecipes()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(true)
    }
    
    /*
    // Test: For testing FetchRecipeList Failure
    */
    func test_FetchRecipeListFailed() {
        let expectation = self.expectation(description: "Fetch")
        expectation.fulfill()
        MockDataServiceProvider.shouldSucceed = false
        viewModel?.fetchRecipes()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(false)
    }
}

class MockDataServiceProvider: DataServiceProvider {
    static var shouldSucceed = true
    
    override func fetchRecipes(onComplete: @escaping (Response)->Void) {
        if MockDataServiceProvider.shouldSucceed {
            onComplete(.success([Recipe(title: "Eat Fit",
                                        description: "Healthy Vegan Diet for a healthy soul and mind",
                                        chefName: "John AppleSeed",
                                        imageURL: URL(string: "https:images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg"),
                                        tags: ["healthy", "vegan"])]))
        } else {
            onComplete(.failure(NSError()))
        }
    }
}
