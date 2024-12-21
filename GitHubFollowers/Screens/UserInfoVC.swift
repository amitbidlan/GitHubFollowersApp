//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/20.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerView = UIView()
    
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    var itemViews:[UIView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewCOntroller()
        layoutUI()
        getUserInfo()
        
    }
    
    func layoutUI(){
        itemViews = [headerView,itemViewOne,itemViewTwo]
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        itemViewOne.backgroundColor = .darkGray
        itemViewTwo.backgroundColor = .darkGray
        
        let padding:CGFloat = 20
        let itemheight:CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemheight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemheight),
            //8;10;34
            
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func add(childVC:UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func configureViewCOntroller(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async{
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
            case .failure(let error):
                self.presentGFAlertonMainThread(title: "Some Error", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
}
