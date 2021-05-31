//
//  Util.swift
//  challenge-ios
//
//  Created by Vitor Campos on 30/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

fileprivate var aView : UIView?

extension NSNumber {
    //MARK:- String Formater
    func valueFormatCurrency() -> String{
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.groupingSeparator = "."
        format.decimalSeparator = ","
        return format.string(from: self) ?? String()
    }
}
//MARK:- SpinnerConfiguration
extension UIViewController {
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { (t) in
            self.removeSpinner()
        }
    }
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
}
