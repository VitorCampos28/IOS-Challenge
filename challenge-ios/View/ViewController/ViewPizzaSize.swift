//
//  ViewPizzaSize.swift
//  challenge-ios
//
//  Created by Vitor Campos on 31/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class ViewPizzaSize: UIViewController{
    @IBOutlet weak var ImagePizza: UIImageView!
    @IBOutlet weak var PizzaName: UILabel!
    @IBOutlet var starsRating: [UIImageView]!
    @IBOutlet weak var buttonP: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonG: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    var pizzaSelected: ReturnApiPizza?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whriteScreen()
        buttonP.layer.cornerRadius = 10
        buttonM.layer.cornerRadius = 10
        buttonG.layer.cornerRadius = 10
    }
    func clickActionButton(buttonClick: Double){
        let pizzaPrice = NSNumber(value: buttonClick)
        let stringFormat = "R$ " + pizzaPrice.valueFormatCurrency()
        self.priceLabel.text = stringFormat
    }
    @IBAction func buttonP(_ sender: Any) {
        clickActionButton(buttonClick: pizzaSelected!.priceP)
    }
    @IBAction func buttonM(_ sender: Any) {
        clickActionButton(buttonClick: pizzaSelected!.priceM)
    }
    @IBAction func buttonG(_ sender: Any) {
        clickActionButton(buttonClick: pizzaSelected!.priceG)
    }
    @IBAction func buttonComprar(_ sender: Any) {
        self.nextScreen(ViewId: "ConfirmationScreen")
    }
    
    func whriteScreen(){
        resetCell()
        guard let url = URL(string: pizzaSelected!.imageUrl) else{
            return
        }
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        ImagePizza.image = UIImage(data: data)
        PizzaName.text = pizzaSelected?.name
        let pizzaPrice = NSNumber(value: pizzaSelected!.priceP)
        let stringFormat = "R$ " + pizzaPrice.valueFormatCurrency()
        self.priceLabel.text = stringFormat
        for (index, stars) in starsRating.enumerated() {
            print(index,stars)
            if index < pizzaSelected!.rating {
                stars.tintColor = .systemYellow
            }
        }
    }
    private func resetCell() {
        self.priceLabel.text = ""
        self.PizzaName.text = ""
        for star in starsRating {
            star.tintColor = .gray
        }
    }
}
