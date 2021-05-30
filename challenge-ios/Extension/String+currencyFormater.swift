//
//  String+currencyFormater.swift
//  challenge-ios
//
//  Created by Thiago Pontes Lima on 30/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import Foundation

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
