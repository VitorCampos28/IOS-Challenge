//
//  PizzaTableViewCell.swift
//  challenge-ios
//
//  Created by Thiago Pontes Lima on 29/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class PizzaTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInsideCell: UIView!
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var labelPizzaName: UILabel!
    @IBOutlet weak var labelPizzaPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(pizza: ReturnApiPizza) {
        let pizzaPrice = NSNumber(value: pizza.priceP)
        let stringFormat = "R$ " + pizzaPrice.valueFormatCurrency()
        self.labelPizzaPrice.text = stringFormat
        self.labelPizzaName.text = "Pizza de " + pizza.name
        self.viewInsideCell.layer.cornerRadius = self.viewInsideCell.frame.height / 10
        self.pizzaImage.layer.cornerRadius = self.pizzaImage.frame.height / 10
    }
    
}
