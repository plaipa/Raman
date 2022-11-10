//
//  ScanQRViewController.swift
//  QR Code
//
//  Created by plaipa on 1/12/22.
//

import UIKit
import MercariQRScanner


class ScanQRViewController: UIViewController {
    
    static var id : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let qrScannerView = QRScannerView(frame: view.bounds)
        
        // Customize focusImage, focusImagePadding, animationDuration
        qrScannerView.focusImage = UIImage(named: "scan_qr_focus")
        qrScannerView.focusImagePadding = 8.0
        qrScannerView.animationDuration = 0.5
        
        qrScannerView.configure(delegate: self)
        cameraView.addSubview(qrScannerView)
        qrScannerView.startRunning()
        
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismissVC()
    }
    

    @IBOutlet weak var cameraView: QRScannerView!
}


// MARK: - QRScannerViewDelegate
extension ScanQRViewController: QRScannerViewDelegate {
    
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error.localizedDescription)
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        let id = code
        ScanQRViewController.id = id
        dismissVC()
        

    }
    
    
}

