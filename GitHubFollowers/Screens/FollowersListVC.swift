//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/17.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section {
        case main
    }
    var username:String!
    var followers : [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var collectionView:UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSouce()
        
       
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in:view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        //collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers(username:String,page:Int){
        showLoading()
        NetworkManager.shared.getFollowers(for: username, page: page){
            [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers )
                if self.followers.isEmpty {
                    let message = "このユーザーにはフォロワーがいません。フォローするには、ここを参照してください。😁"
                    DispatchQueue.main.async{
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData()
            case .failure(let error): 
                self.presentGFAlertonMainThread(title: "悪いことが起こった。", message: error.rawValue, buttonTitle:"閉じる")
            }
        }
    }
    
    
    func configureDataSouce(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: {
            (collectionView,indexPath,follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async{
            self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    

}


extension FollowersListVC:UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            print("OUR NEXT PAGE \(page)")
            getFollowers(username: username, page: page)
        }
    }
}
