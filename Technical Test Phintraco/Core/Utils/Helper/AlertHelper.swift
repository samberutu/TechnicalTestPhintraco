//
//  AlertHelper.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import UIKit

class AlertHelper {
    var requestAction: Void = ()
    private class func notificationAlert(message: String, viewController: UIViewController, action: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Muat Kembali", style: .cancel) { _ in
            guard let callback = action else { return }
            callback()
        }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func displayError(message: String, viewController: UIViewController, action: (() -> Void)? = nil) {
        
        notificationAlert(message: message, viewController: viewController, action: action)
    }
    
    static func displaySuccess(message: String, viewController: UIViewController, action: (() -> Void)? = nil) {
        
        notificationAlert(message: message, viewController: viewController, action: action)
    }
}
