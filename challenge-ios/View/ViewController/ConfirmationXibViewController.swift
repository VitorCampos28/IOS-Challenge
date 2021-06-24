//
//  ConfirmationXibViewController.swift
//  challenge-ios
//
//  Created by Vitor Natal on 24/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class ConfirmationXibViewController: UIViewController {
    @IBOutlet weak var voltarButton: UIButton!
    override func viewDidLoad() {
        voltarButton.layer.cornerRadius = 10
        super.viewDidLoad()
    }
    
    @IBAction func clickVoltarButton(_ sender: Any) {
        /// Utilizar Pop nessa parte
        self.popToViewControllerWithType(type: PizzaListViewControllerXib.self)
    }

}
