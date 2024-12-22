//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}



enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite:Follower, actionType:PersistenceActionType, completed: @escaping(GFError?)-> Void){
        retreiveFavorites{ result in
            switch result {
            case .success(let favorites):
                var retreivedfavorites = favorites
                switch actionType {
                case .add:
                    guard !retreivedfavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retreivedfavorites.append(favorite)
                            
                case .remove:
                    retreivedfavorites.removeAll{
                        $0.login == favorite.login
                    }
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retreiveFavorites(completed: @escaping (Result<[Follower],GFError>) -> Void){
        guard let favoritesdata = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesdata)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableFavorites))
        }
    }
    
    static func save(favorites:[Follower]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return .unableFavorites
        }
        
    }
}
