//
//  APIs.swift
//  Raman
//
//  Created by plaipa on 11/4/22.
//

import Foundation
import UIKit
import AuthenticationServices
import Firebase

extension UIViewController {
    
    func checkCIP(id: String) {
        print("CIP Called, id: \(id)")
        
        var checksArray = [String()]
        checksArray = UserDefaults.standard.array(forKey: "checks") as? [String] ?? [String]()
        checksArray.append("ID:\(id)      \(getTime()) \(getToday())")
        UserDefaults.standard.set(checksArray, forKey: "checks")
        
        DispatchQueue.main.async {
            let param : [String: Any] = ["code": id]
            HttpUtility.shared.postApiDataJson(requestUrl: "https://client.raman24.com/api/v3/cip/getCipUserWithCode", param: param, completionHandler: {res in
                
                let message = res["message"].string
                let name = res["data"].dictionary?["user"]?.string

                if message == "success" {
                    
                    Database.database().reference().child("TabrizCIP").child(self.getToday()).childByAutoId().setValue("<\(self.getTime())> _ نام:\(name ?? "")  _  کد ملی:\(id)") { (error, dataBaseReference) in
                        if error == nil {
                            PopupViewController.id = id
                            PopupViewController.name = name
                            PopupViewController.alert = "correct"
                            self.performSegue(withIdentifier: "PopupViewController", sender: nil)
                            
                        }else {
                            let alert = UIAlertController(title: "مشکل در اتصال به اینترنت", message: nil, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "متوجه شدم", style: .cancel))
                            self.present(alert, animated: true)
                            
                        }
                    }
                    
                } else {
                    PopupViewController.id = id
                    PopupViewController.alert = "incorrect"
                    self.performSegue(withIdentifier: "PopupViewController", sender: nil)
                }
                
                
                
                
            })
        }
        
        
    }
}
