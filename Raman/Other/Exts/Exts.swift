//
//  Exts.swift
//  Pinvoice
//
//  Created by plaipa on 2/23/1400 AP.
//

import Foundation
import UIKit

extension NumberFormatter {
    func formatWithSeparator (number: Int) -> String {
        self.numberStyle = .decimal
        self.groupingSeparator = ",";
        return self.string(from: number as NSNumber)!;
    }
}






extension String {
    
    func checkID() -> Bool {
        if self.count == 10 {
            if (Int(self) ?? 0) + 1 != 1 {
                return true
            }
        }
        return false
    }
    
    func englishNumbers() -> String? {
        let oldCount = self.count
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        
        if let final = formatter.number(from: self) {
            let newCount = "\(final)".count
            let differ = oldCount - newCount
            if differ < 1 {
                return "\(final)"
            } else {
                var outFinal = "\(final)"
                for _ in 1...differ {
                    outFinal = "0" + outFinal
                }
                return outFinal
            }
        } else {
            return nil
        }
    }
    
    
    func englishNumbersWithDouble() -> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        
        
        let oldCount = String((formatter.number(from: self)?.doubleValue) ?? 0.0).count
        

        
        if let x = formatter.number(from: self)?.doubleValue {
            let final = String(format: "%.1f", Double(x))


            let newCount = "\(final)".count
            let differ = oldCount - newCount
            if differ < 1 {
                return "\(final)"
            } else  {
                var outFinal = "\(final)"
                for _ in 1...differ {
                    outFinal = "0" + outFinal
                }
                return outFinal
            }
        } else {
            return nil
        }
    }
}






extension String {

    func currencyFormatting() -> String {
        if UserDefaults.standard.string(forKey: "appLanguage") != "" {

            if let value = Double(self) {
                let formatter = NumberFormatter()
                formatter.locale = Locale(identifier: UserDefaults.standard.string(forKey: "appLanguage") ?? "")
                formatter.numberStyle = .currency
                formatter.maximumFractionDigits = 2
                formatter.minimumFractionDigits = 2
                if let str = formatter.string(for: value) {
                    return str
                }
            }
            
        } else {
        
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        
        }

        
        return ""
    }
}




extension UIView {
    
    
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }

    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)

        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale

        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }

        return image
    }
}


extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull ])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}



func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number ?? 0)
        return faNumber!

    }



extension UIViewController {
    
    
    func textFieldPadding(_ textField: UITextField) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    
    
    
    func dismissVC() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    

}


extension UIViewController {
    
    

    
    func getToday() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = NSLocale(localeIdentifier: "fa_IR") as Locale
        formatter.calendar = NSCalendar(identifier: NSCalendar.Identifier.persian) as Calendar?
        
        return  formatter.string(from: date)
    }
    
    func getTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = NSLocale(localeIdentifier: "en_IR") as Locale
        
        return  formatter.string(from: date)
    }

    
    
    enum AssetIdentifier : String {
        case blueBackground = "Background"
        case secondBackground = "Second Background"
        case titleDetails = "Title-Details"
        case titleMain = "Title-Main"
    }
    
    func assetColors(color: AssetIdentifier) -> UIColor {
        return UIColor(named: color.rawValue) ?? UIColor()
    }
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    func checkFreeAds() -> Bool {
        
        let userDefaults : String? = UserDefaults.standard.string(forKey: "ExpireDate")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"

        let expire = dateFormatter.date(from: userDefaults ?? "2000/01/01")
        
        let now = Date()


        if ((expire ?? Date()) <= now) {
            return false
        } else {
            return true
        }
        
    }
}




