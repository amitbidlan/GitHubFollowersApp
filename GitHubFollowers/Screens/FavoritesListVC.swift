//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/16.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        PersistenceManager.retreiveFavorites{
            result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
    

}
