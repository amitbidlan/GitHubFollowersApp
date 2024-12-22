//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/21.
//

import Foundation

class GFFollowerItemVC:GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemBlue, title: "フォロワーを獲得する")
        
    }
    
    override func actionButtonTapped() {
        
        delegate.didTapGetFollowers(for: user)
    }
}
