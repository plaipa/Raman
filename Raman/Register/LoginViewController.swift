//
//  LoginViewController.swift
//  Raman
//
//  Created by plaipa on 9/25/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()


        hideKeyboardWhenTappedAround()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == passwordTF {
            loginAction()
        }
        return true
    }
    
    func loginAction() {
        if emailTF.text == "cip.tabriz@raman.com" && passwordTF.text == "09140914" {
            UserDefaults.standard.set(emailTF.text, forKey: "UserType")
            performSegue(withIdentifier: "ViewController", sender: nil)
        }else {
            let alert = UIAlertController(title: nil, message: "ایمیل یا پسورد وارد شده صحیح نمیباشد", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تلاش مجدد", style: .cancel))
            present(alert, animated: true)
        }
    }

    @IBAction func loginButton(_ sender: UIButton) {
        loginAction()
    }
    

    

    
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
}
