//
//  TableViewCell.swift
//  challenge-ios
//
//  Created by Vitor Natal on 23/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK: - Outlet
    @IBOutlet weak var viewInsideCell: UIView!
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var labelPizzaName: UILabel!
    @IBOutlet weak var labelPizzaPrice: UILabel!
    @IBOutlet var reviewStars: [UIImageView]!
    
    //MARK: - Constants
    fileprivate enum Constants{
        static let kCurrencyType =  "R$ "
        static let kPizzaTitle = "Pizza de "
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Updating Cell
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
        let stringFormat = Constants.kCurrencyType + pizzaPrice.valueFormatCurrency()
        self.labelPizzaPrice.text = stringFormat
        self.labelPizzaName.text = Constants.kPizzaTitle + pizza.name
        self.viewInsideCell.layer.cornerRadius = 10
        self.pizzaImage.layer.cornerRadius = 10
        
        for (index, star) in reviewStars.enumerated() {
            if index < pizza.rating {
                star.tintColor = .systemYellow
            }
        }
    }
    //MARK: - Reset cell
    private func resetCell() {
        self.labelPizzaPrice.text = String()
        self.labelPizzaName.text = String()
        for star in reviewStars {
            star.tintColor = .gray
        }
    }

}
