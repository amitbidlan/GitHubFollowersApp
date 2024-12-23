//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/16.
//

import UIKit

class FavoritesListVC: UIViewController {
    let tableView = UITableView()
    var favorites:[Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "お気に入り"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        
    }
    
    func getFavorites(){
        PersistenceManager.retreiveFavorites{
           [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "お気に入りがマークされていません。\nお気に入りを追加してください。", in: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                self.favorites = favorites
            case .failure(let error):
                self.presentGFAlertonMainThread(title: "何か問題が発生しました。", message: error.rawValue, buttonTitle: "閉じる")
            }
        }
    }

}


extension FavoritesListVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC,animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove){[weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                return
            }
            self.presentGFAlertonMainThread(title: "削除できません。", message:error.rawValue, buttonTitle: "閉じる")
            
        }
    }
    
    
}
