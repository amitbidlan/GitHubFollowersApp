//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/17.
//

import UIKit

extension UIViewController {
    func presentGFAlertonMainThread(
        title:String,message:String,buttonTitle:String
    ){
        DispatchQueue.main.async{
            let alertVC = GFAlertVC(alertTitle: title,message: message,buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
