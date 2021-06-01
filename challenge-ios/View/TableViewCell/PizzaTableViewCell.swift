//
//  PizzaTableViewCell.swift
//  challenge-ios
//
//  Created by Vitor Campos on 29/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class PizzaTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInsideCell: UIView!
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var labelPizzaName: UILabel!
    @IBOutlet weak var labelPizzaPrice: UILabel!
    @IBOutlet var reviewStars: [UIImageView]!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(pizza: ReturnApiPizza) {
        resetCell()
        guard let url = URL(string: pizza.imageUrl) else{
            return
        }
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        pizzaImage.image = UIImage(data: data)
        let pizzaPrice = NSNumber(value: pizza.priceP)
        let stringFormat = "R$ " + pizzaPrice.valueFormatCurrency()
        self.labelPizzaPrice.text = stringFormat
        self.labelPizzaName.text = "Pizza de " + pizza.name
        self.viewInsideCell.layer.cornerRadius = 10
        self.pizzaImage.layer.cornerRadius = 10
        
        for (index, star) in reviewStars.enumerated() {
            if index < pizza.rating {
                star.tintColor = .systemYellow
            }
        }
    }
    
    private func resetCell() {
        self.labelPizzaPrice.text = ""
        self.labelPizzaName.text = ""
        for star in reviewStars {
            star.tintColor = .gray
        }
    }
    
}
