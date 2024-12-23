//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/16.
//

import UIKit

class SearchVC: UIViewController {
    
    
    let logoImageView = UIImageView()
    let headlineTitleView = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemOrange, title: "検索")
    
    var isUsernameEntered : Bool {
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTitle()
        configureTextField()
        configureButton()
        createDIsmissKeyboardTapGesture()
        registerForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDIsmissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func registerForKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc func keyboardWillShow(_ notification: Notification) {
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            let keyboardHeight = keyboardFrame.height
            
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight / 4
            }
        }
        
        @objc func keyboardWillHide(_ notification: Notification) {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    
    @objc func pushFollowerListVC(){
        usernameTextField.resignFirstResponder()
        guard isUsernameEntered  else {
            presentGFAlertonMainThread(title: "ユーザー名が空白です。", message: "ユーザー名が入力されていません。正しいユーザー名を入力してください。🙇🏻‍♂️", buttonTitle: "閉じる")
            return
            }
        let followerListVC = FollowersListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
         
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "github_logo")!
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
    func configureTitle(){
        
        view.addSubview(headlineTitleView)
        headlineTitleView.text = "フォロワーを検索"
        NSLayoutConstraint.activate([
            headlineTitleView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            headlineTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            headlineTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            headlineTitleView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: headlineTitleView.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    
    func configureButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

extension SearchVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
       // textField.resignFirstResponder()
        return true
    }
    
}
