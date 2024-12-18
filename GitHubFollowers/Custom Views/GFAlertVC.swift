//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/17.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center, fontSize: 15)
    let actionButton = GFButton(backgroundColor: .secondarySystemBackground, title: "閉じる")
    let padding:CGFloat = 20
    var alertTitle : String?
    var message:String?
    var buttonTitle:String?
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something Went Wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        
    }
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:-padding),
            actionButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-padding),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureBodyLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor , constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
   
    

}
