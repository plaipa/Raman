//
//  SceneDelegate.swift
//  Raman
//
//  Created by plaipa on 9/7/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        self.window = UIWindow(windowScene: windowScene)
        var rootViewController : UIViewController!
        
        
        if UserDefaults.standard.string(forKey: "UserType") == nil {
            rootViewController = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")

        }else {
            rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")

        }
            

        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        
    }


}

