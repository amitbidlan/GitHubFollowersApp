//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/18.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "github_logo")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 8
        clipsToBounds      = true
        image              = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
