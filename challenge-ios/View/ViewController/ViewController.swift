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
    @IBOutlet weak var passwordTextField: UITextField!
    
    var apiConnection = ApiConnection()
    var user: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func nextScreen(){
        guard let storyboard = self.storyboard, let navController = self.navigationController else { return }
        let pizzaViewController = storyboard.instantiateViewController(identifier: "pizzaListViewController")
        navController.pushViewController(pizzaViewController, animated: true)
    }
    //MARK:- ClickButton
    @IBAction func loginAction(_ sender: Any) {
        user = userTextField.text!
        password = passwordTextField.text!
        if (!user.isEmpty && !password.isEmpty){
            apiConnection.login(user: user, passWord: password)
            nextScreen()
        }else{
            print("Credential error")
        }
    }
    
}

