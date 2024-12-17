//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/17.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment:NSTextAlignment,fontSize:CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
