//
//  DataServiceProvider.swift
//  RecipeLite
//
//  Created by Koushal, KumarAjitesh on 2020/01/20.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Contentful

// API Service Protocol

class DataServiceProvider {
    
    enum Response {
        case success([Recipe])
        case failure(Error)
    }
    
    // MARK: - Fetch Recipes API call
    
    func fetchRecipes(onComplete: @escaping (Response)->Void) {
        let contentType = "recipe"
        let client = Client(spaceId: Configuration.CONTENTFUL_SPACE_ID,
                            environmentId: Configuration.CONTENTFUL_ENVIRONMENT_ID,
                            accessToken: Configuration.CONTENTFUL_ACCESS_TOKEN)
        let query = Query.where(contentTypeId: contentType)
        
        client.fetchArray(of: Entry.self, matching: query) { (result: Result<HomogeneousArrayResponse<Entry>>) in
            switch result {
            case .success(let arrayResponse):
                let entries = arrayResponse.items
                onComplete(.success(entries.map(Recipe.init)))
            case .error(let error):
                onComplete(.failure(error))
            }
        }
    }
}

