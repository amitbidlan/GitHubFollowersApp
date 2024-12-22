//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/21.
//

import UIKit

class GFRepoItemVC:GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemRed, title: "github プロフィール")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
