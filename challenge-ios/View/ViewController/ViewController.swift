//
//  ViewController.swift
//  challenge-ios
//
//  Created by Vitor Campos on 28/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    var apiConnection = ApiConnection()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
   //MARK:- Pass to next screen
    @IBAction func loginAction(_ sender: Any) {
        guard let storyboard = self.storyboard, let navController = self.navigationController else { return }
        let pizzaViewController = storyboard.instantiateViewController(identifier: "pizzaListViewController")
        navController.pushViewController(pizzaViewController, animated: true)
        
        
    }
    
}

