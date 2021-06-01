//
//  ConfirmationScreen.swift
//  challenge-ios
//
//  Created by Vitor Campos on 31/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class ConfirmationScreen: UIViewController {
    @IBOutlet weak var voltarButton: UIButton!
    override func viewDidLoad() {
        voltarButton.layer.cornerRadius = 10
        super.viewDidLoad()
    }
    
    @IBAction func clickVoltarButton(_ sender: Any) {
        self.nextScreen(ViewId: "pizzaListViewController")
    }
}
