//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/16.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Custom Code
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor:UIColor,title:String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius    = 4
        setTitleColor(.white, for: .normal)
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor:UIColor, title:String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        
    }
}
