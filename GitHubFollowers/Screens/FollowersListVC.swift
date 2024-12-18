//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/17.
//

import UIKit

class FollowersListVC: UIViewController {
    var username:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: username, page: 1){
            result in
            
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertonMainThread(title: "悪いことが起こった。", message: error.rawValue, buttonTitle:"閉じる")
            }
            

            
        }
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
