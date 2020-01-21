//
//  RecipeCell.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/21.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeCell: UITableViewCell {
    
    // MARK: - Lazy Initializers
    
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
    
    private lazy var bottomPadding: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizing(height: 20).activate()
        return view
    }()
    
    private lazy var recipeStackView: UIStackView = {
        let sView = UIStackView(frame: .zero)
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .vertical
        sView.alignment = .leading
        return sView
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpStackViewContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up stack view UI
    
    private func setUpStackViewContents(){
        recipeStackView.addArrangedSubview(recipeImage)
        recipeStackView.addArrangedSubview(recipeTitle)
        recipeStackView.addArrangedSubview(bottomPadding)
        addSubview(recipeStackView)
        
        recipeStackView.edgesAnchorEqualTo(destinationView: self).activate()
    }
    
    // MARK: - Configure cell with RecipeListViewModel
    
    func configureCell(recipe: Recipe?){
        guard let title = recipe?.title,
            let imageUrl = recipe?.imageURL else { return}
        recipeImage.sd_setImage(with: imageUrl)
        self.recipeTitle.text = title
    }
}
