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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var buttonP: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonG: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    var pizzaSelected: ReturnApiPizza?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whriteScreen()
        configButtonCorner()
    }
    
    fileprivate func configButtonCorner() {
        buttonP.layer.cornerRadius = 10
        buttonM.layer.cornerRadius = 10
        buttonG.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
    }
    //MARK: -Clicks Events
    @IBAction func buttonP(_ sender: Any) {
        clickActionButton(buttonClick: pizzaSelected!.priceP)
        buttonP.backgroundColor = .green
        buttonM.backgroundColor = .white
        buttonG.backgroundColor = .white
        buttonG.setTitleColor(.black, for: .normal)
        buttonM.setTitleColor(.black, for: .normal)
        buttonP.setTitleColor(.white, for: .normal)
    }
    @IBAction func backToList(_ sender: Any) {
        self.nextScreen(ViewId: "pizzaListViewController")
    }
    @IBAction func buttonM(_ sender: Any) {
        clickActionButton(buttonClick: pizzaSelected!.priceM)
        buttonP.backgroundColor = .white
        buttonM.backgroundColor = .green
        buttonG.backgroundColor = .white
        buttonG.setTitleColor(.black, for: .normal)
        buttonM.setTitleColor(.white, for: .normal)
        buttonP.setTitleColor(.black, for: .normal)
    }
    @IBAction func buttonG(_ sender: Any) {
        clickActionButton(buttonClick: pizzaSelected!.priceG)
        buttonP.backgroundColor = .white
        buttonM.backgroundColor = .white
        buttonG.backgroundColor = .green
        buttonG.setTitleColor(.white, for: .normal)
        buttonM.setTitleColor(.black, for: .normal)
        buttonP.setTitleColor(.black, for: .normal)
    }
    @IBAction func buttonComprar(_ sender: Any) {
        self.nextScreen(ViewId: "ConfirmationScreen")
    }
    
    func clickActionButton(buttonClick: Double){
        let pizzaPrice = NSNumber(value: buttonClick)
        let stringFormat = "R$ " + pizzaPrice.valueFormatCurrency()
        self.priceLabel.text = stringFormat
    }
    //MARK: - Reload Screen
    func whriteScreen(){
        resetCell()
        urlToImage()
        PizzaName.text = "Pizza de " + pizzaSelected!.name
        let pizzaPrice = NSNumber(value: pizzaSelected!.priceP)
        let stringFormat = "R$ " + pizzaPrice.valueFormatCurrency()
        self.priceLabel.text = stringFormat
        
        for (index, stars) in starsRating.enumerated() {
            if index < pizzaSelected!.rating {
                stars.tintColor = .systemYellow
            }
        }
    }
    //MARK: - URL to image
    private func urlToImage(){
        guard let url = URL(string: pizzaSelected!.imageUrl) else{
            return
        }
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        ImagePizza.image = UIImage(data: data)
    }
    //MARK: - Reset screen
    private func resetCell() {
        self.priceLabel.text = ""
        self.PizzaName.text = ""
        for star in starsRating {
            star.tintColor = .gray
        }
    }
}
