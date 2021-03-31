//
//  UIViewControllerExtension.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showLoading() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showErrorAlert(_ msg: String?) {
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            })
        )
        self.present(alertController, animated: true, completion: nil)
    }
}
