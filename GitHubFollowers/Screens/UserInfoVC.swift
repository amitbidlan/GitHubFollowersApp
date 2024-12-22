//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/20.
//

import UIKit


protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerView = UIView()
    
    let itemViewOne = UIView()
    
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center,fontSize: 13)
    var itemViews:[UIView] = []
    
    weak var delegate : FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewCOntroller()
        getUserInfo()
        layoutUI()
        
        
    }
    
    func configureUIElements(with user:User){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "「\(user.createdAt.convertToDisplayFormat())からGitHubユーザー」"
    }
    
    func layoutUI(){
        
         let padding:CGFloat = 20
         let itemheight:CGFloat = 140
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLabel]
       
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemheight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemheight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
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
                    self.configureUIElements(with: user)
                }
                
            case .failure(let error):
                self.presentGFAlertonMainThread(title: "Some Error", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
}

extension UserInfoVC:UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertonMainThread(title: "無効なURL", message: "このユーザーに添付された URL は無効です。", buttonTitle: "戻る")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertonMainThread(title: "フォロワーなし", message:"このユーザーにはフォロワーがいません。", buttonTitle: "戻る")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
   
    
    
}
