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
        loginButton.layer.cornerRadius = 10
    }
    
    //MARK:- funcCreatingAlert
    func creatingAlert(){
        let alert = UIAlertController(title: "Login Error", message: "both fields must be filled.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    //MARK:- ClickButton
    @IBAction func loginAction(_ sender: Any) {
        user = userTextField.text!
        password = passwordTextField.text!
        if (!user.isEmpty && !password.isEmpty){
            apiConnection.login(user: user, passWord: password)
            self.nextScreen(ViewId: "pizzaListViewController")
        }else{
            creatingAlert()
        }
    }
    
}

