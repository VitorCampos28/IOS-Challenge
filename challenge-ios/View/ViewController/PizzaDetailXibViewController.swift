//
//  PizzaDetailXibViewController.swift
//  challenge-ios
//
//  Created by Vitor Natal on 24/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class PizzaDetailXibViewController: UIViewController {
    //MARK: -Outlets
    @IBOutlet weak var ImagePizza: UIImageView!
    @IBOutlet weak var PizzaName: UILabel!
    @IBOutlet var starsRating: [UIImageView]!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var sizeButtonList: [UIButton]!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: -Variables
    var pizzaSelected: ReturnApiPizza?
    
    //MARK: - Constants
    fileprivate enum Constants{
        static let kViewController = "ConfirmationViewController"
        static let kCurrencyType =  "R$ "
        static let kPizzaTitle = "Pizza de "
    }
    init(pizzaSelected: ReturnApiPizza?) {
        self.pizzaSelected = pizzaSelected
        super.init(nibName: "PizzaDetailXibViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configButtonCorner()
    }
    //MARK:- ConfigButtons
    fileprivate func configButtonCorner() {
        backButton.layer.cornerRadius = 10
        // Set Button styles
        for button in sizeButtonList {
            setButtonStyle(button: button)
        }
    }
    private func setButtonStyle(button: UIButton) {
        let isButtonSelected = button.isSelected
        let backgroundColor = isButtonSelected ? UIColor.green : UIColor.white
        let titleColor = isButtonSelected ? UIColor.white : UIColor.black
        
        button.backgroundColor = backgroundColor
        button.tintColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
        button.layer.cornerRadius = 10
    }
    
    //MARK: -Clicks Events
    @IBAction func backToList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sizeSelected(_ sender: UIButton) {
        // verificar qual botão é o selecionado
        for button in sizeButtonList {
            if button.titleLabel?.text == sender.titleLabel?.text {
                clickActionButton(selectedButton: button)
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            setButtonStyle(button: button)
        }
    }
    func clickActionButton(selectedButton: UIButton){
        let pizzaPrice = NSNumber(value: getPriceByButton(selectedButton))
        let stringFormat =  Constants.kCurrencyType + pizzaPrice.valueFormatCurrency()
        self.priceLabel.text = stringFormat
    }
    
    private func getPriceByButton(_ button: UIButton) -> Double {
        guard let buttonTitle = button.titleLabel?.text, let selectedPizza = pizzaSelected else { return 0.00 }
        switch buttonTitle {
        case "P":
            return selectedPizza.priceP
        case "M":
            return selectedPizza.priceM
        case "G":
            return selectedPizza.priceG
        default:
            return 0.00
        }
    }
    
    @IBAction func buttonComprar(_ sender: Any) {
        self.navigationController?.pushViewController(ConfirmationXibViewController(nibName: "ConfirmationXibViewController", bundle: nil), animated: true)
    }
    
    
    //MARK: - SetupView
    func setupView(){
        resetCell()
        urlToImage()
        
        guard let pizzaSelected = pizzaSelected else { return }
        PizzaName.text = Constants.kPizzaTitle + pizzaSelected.name
        let pizzaPrice = NSNumber(value: pizzaSelected.priceP)
        let stringFormat = Constants.kCurrencyType + pizzaPrice.valueFormatCurrency()
        self.priceLabel.text = stringFormat
        
        for (index, stars) in starsRating.enumerated() {
            if index < pizzaSelected.rating {
                stars.tintColor = .systemYellow
            }
        }
    }
    //MARK: - URL to image
    private func urlToImage(){
        guard let pizzaSelected = pizzaSelected else { return }
        guard let url = URL(string: pizzaSelected.imageUrl) else{
            return
        }
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        ImagePizza.image = UIImage(data: data)
    }
    //MARK: - Reset screen
    private func resetCell() {
        self.priceLabel.text = String()
        self.PizzaName.text = String()
        for star in starsRating {
            star.tintColor = .gray
        }
    }

}
