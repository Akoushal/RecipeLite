//
//  RecipeListViewController.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/20.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {

    // MARK: - Lazy Initializers
    
    private lazy var recipeListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alpha = 0
        tableView.register(RecipeCell.self, forCellReuseIdentifier: CellIdentifiers.recipeCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let actInd = UIActivityIndicatorView(frame: .zero)
        actInd.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            actInd.style = .large
        } else {
            actInd.style = .whiteLarge
        }
        
        actInd.startAnimating()
        actInd.hidesWhenStopped = true
        return actInd
    }()
    
    private var errorTag: Error?
    
    // MARK: - Injection
    
    private var viewModel: RecipeListViewModel?
    
    //MARK:- Initializer
    
    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = nil
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationAttributes()
        setUpUI()
        attemptFetchRecipeList()
    }
    
    // MARK: - Private Methods
    
    private func attemptFetchRecipeList() {
        viewModel?.fetchRecipes()
        
        viewModel?.updateLoadingStatus = {
            if let isLoading = self.viewModel?.isLoading {
                let _ = isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
            }
        }
        
        viewModel?.showAlertClosure = {
            if let error = self.viewModel?.error {
                self.errorTag = error
                DispatchQueue.main.async {
                    self.presentAlert()
                }
            }
        }
        
        viewModel?.didFinishFetch = {
            //Update UI
            DispatchQueue.main.async {
                self.recipeListTableView.alpha = 1
                self.recipeListTableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Setup
    
    private func setUpNavigationAttributes() {
        title = "Eat Fit"
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(recipeListTableView)
        view.addSubview(activityIndicator)
        
        recipeListTableView.edgesAnchorEqualTo(destinationView: view).activate()
        activityIndicator.centerEdgesAnchorEqualTo(destinationView: view).activate()
    }
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UITableViewDataSource

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.recipeList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.recipeCell, for: indexPath) as? RecipeCell else { return UITableViewCell()}
        cell.configureCell(recipe: viewModel?.recipeList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRecipe(at: indexPath.row)
    }
}

// MARK: - Alert Protocol

extension RecipeListViewController: AlertPresentable {
    
    var alertComponents: AlertComponents {
        guard let error = self.errorTag else { return AlertComponents(title: nil, actions: []) }
        let okAction = AlertActionComponent(title: "OK", style: .cancel, handler: nil)
        let alertComponents = AlertComponents(title: AlertTitle.ErrorTitle, message: error.localizedDescription, actions: [okAction], completion: nil)
        return alertComponents
    }
}
