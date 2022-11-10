//
//  ViewController.swift
//  Raman
//
//  Created by plaipa on 10/18/22.
//

import UIKit
import CoreNFC
import Firebase


class ViewController: UIViewController {
    
    var nfcSection: NFCNDEFReaderSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if ScanQRViewController.id != nil {
            if ScanQRViewController.id?.checkID() == true {
                checkCIP(id: ScanQRViewController.id ?? "")
            }else {
                PopupViewController.id = ScanQRViewController.id
                PopupViewController.alert = "typeIncorrect"
                performSegue(withIdentifier: "PopupViewController", sender: nil)
            }
            ScanQRViewController.id = nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func submitUser(id: String) {
        
        if id.checkID() == true {
            checkCIP(id: id)
        }else {
            PopupViewController.id = id
            PopupViewController.alert = "typeIncorrect"
            performSegue(withIdentifier: "PopupViewController", sender: nil)
        }
        
    }
    
    @IBAction func scanQRCode(_ sender: UIButton) {
        performSegue(withIdentifier: "ScanQRViewController", sender: nil)
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "آیا مایل به خروج از حساب کاربری خود هستید", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "خیر", style: .cancel))
        alert.addAction(UIAlertAction(title: "بله", style: .destructive, handler: { _ in
            UserDefaults.standard.set(nil, forKey: "UserType")
            self.performSegue(withIdentifier: "LoginViewController", sender: nil)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func historyButton(_ sender: UIButton) {
        let hsitoryAlert = UIAlertController(title: nil, message: "لطفا رمز عبور را وارد کنید.", preferredStyle: .alert)

        hsitoryAlert.addAction(UIAlertAction(title: "تایید", style: .default, handler: { [weak hsitoryAlert] (_) in
            let signatureNameTF = hsitoryAlert?.textFields?[0] // Force unwrapping because we know it exists.
            if signatureNameTF?.text == "Raman.0914" {
                self.performSegue(withIdentifier: "HistoryViewController", sender: nil)
            } 
        }))
        
        hsitoryAlert.addTextField { (textField) in
            textField.placeholder = "رمز عبور"
            textField.textAlignment = .center
        }
        
        hsitoryAlert.actions[0].isEnabled = false
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:hsitoryAlert.textFields?[0],queue: OperationQueue.main) { (notification) -> Void in

            let textField = hsitoryAlert.textFields?[0]
            
            if textField?.text == "" {
                hsitoryAlert.actions[0].isEnabled = false
            }else {
                hsitoryAlert.actions[0].isEnabled = true

            }
           }

        hsitoryAlert.addAction(UIAlertAction(title: "لغو", style: .cancel))
        self.present(hsitoryAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func scanNFCButton(_ sender: UIButton) {
        nfcSection = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSection?.begin()
        
    }
}

extension ViewController: NFCNDEFReaderSessionDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf16) ?? "Format not supported"
        }
        DispatchQueue.main.async {
            self.submitUser(id: result)
            print(result)
        }
    }
}

