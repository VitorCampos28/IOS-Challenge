//
//  ConfirmationScreen.swift
//  challenge-ios
//
//  Created by Thiago Pontes Lima on 31/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class ConfirmationScreen: UIViewController {
    @IBOutlet weak var voltarButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickVoltarButton(_ sender: Any) {
        self.nextScreen(ViewId: "pizzaListViewController")
    }
}
