//
//  PopupViewController.swift
//  Raman
//
//  Created by plaipa on 10/21/22.
//

import UIKit

class PopupViewController: UIViewController {

    static var id : String?
    static var name : String?
    static var alert : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        switch PopupViewController.alert {
            
        case "correct":
            alertIconImageView.image = UIImage(named: IconIsCorrect.isCorrect.rawValue)
            alertLabel.text = "کاربر تایید شد"
            detailTextView.text = "کاربر به کد ملی \(PopupViewController.id ?? "") و به نام \(PopupViewController.name ?? "") مجاز به دریافت خدمات میباشد."

        case "incorrect":
            alertIconImageView.image = UIImage(named: IconIsCorrect.isInCorrect.rawValue)
            alertLabel.text = "عدم تایید کاربر"
            detailTextView.text = "کاربر به کد ملی \(PopupViewController.id ?? "") مجاز به دریافت خدمات نمیباشد."
            
        case "typeIncorrect":
            alertLabel.text = "فرمت نامعتبر است"
            detailTextView.text = "لطفا کد QR یا کارت NFC را چک کنید."
            alertIconImageView.image = UIImage(named: IconIsCorrect.isInCorrect.rawValue)
        case .none:
            break
        case .some(_):
            break
        }
        
    }


    enum IconIsCorrect : String {
        case isCorrect = "Correct"
        case isInCorrect = "Incorrect"
    }

    @IBAction func okButton(_ sender: UIButton) {
        dismissVC()
    }
    @IBOutlet weak var alertIconImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
}
