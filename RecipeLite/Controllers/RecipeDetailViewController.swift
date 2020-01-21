//
//  RecipeDetailViewController.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/21.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Lazy Initializers
    
    private lazy var contentScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let sView = UIStackView(frame: .zero)
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .vertical
        sView.alignment = .leading
        sView.spacing = 10
        return sView
    }()
    
    private lazy var recipeImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.sizing(height: 200).activate()
        return imageView
    }()
    
    private lazy var recipeTitle: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var recipeDescription: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var tagsLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var chefNameLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Injection
    
    private var viewModel: RecipeDetailViewModel?
    
    // MARK: - Initializer
    
    init(viewModel: RecipeDetailViewModel) {
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
        setUpUI()
        configureView()
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        view.backgroundColor = .white
        detailsStackView.addArrangedSubview(recipeImage)
        detailsStackView.addArrangedSubview(recipeTitle)
        if let tags = viewModel?.tags, tags.count > 0 {
            detailsStackView.addArrangedSubview(tagsLabel)
        }
        if (viewModel?.chefName) != nil {
            detailsStackView.addArrangedSubview(chefNameLabel)
        }
        detailsStackView.addArrangedSubview(recipeDescription)
        contentScrollView.addSubview(detailsStackView)
        view.addSubview(contentScrollView)
        
        contentScrollView.edgesAnchorEqualTo(destinationView: view).activate()
        detailsStackView.edgesAnchorEqualTo(destinationView: contentScrollView, top: 0, left: 0, right: 0).activate()
        detailsStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor).isActive = true
    }
    
    /// Configure View with data
    private func configureView() {
        guard let title = viewModel?.title,
            let imageUrl = viewModel?.imageUrl,
            let description = viewModel?.description
            else { return}
        recipeImage.sd_setImage(with: imageUrl)
        recipeTitle.text = title
        recipeDescription.text = description
        
        if let chefName = viewModel?.chefName {
            chefNameLabel.text = "Chef: " + chefName.localizedCapitalized
        }
        
        if let tags = viewModel?.tags, tags.count > 0 {
            let tagsTextCombined = "Tags Included: " + tags.joined(separator: ", ").localizedCapitalized
            tagsLabel.text = tagsTextCombined
        }
    }
}
