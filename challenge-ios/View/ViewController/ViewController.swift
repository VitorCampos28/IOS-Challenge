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
    //MARK: - Outlet
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Variables
    var apiConnection = ApiConnection()
    var user: String = ""
    var password: String = ""
    
    //MARK: -Constants
    fileprivate enum Constants {
        static let kLoginError = "Login Error"
        static let kErrorLoginMessage = "both fields must be filled."
        static let kViewController = "pizzaListViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
    }
    
    //MARK:- funcCreatingAlert
    func creatingAlert(){
        let alert = UIAlertController(title: Constants.kLoginError, message: Constants.kErrorLoginMessage , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    //MARK:- ClickButton
    @IBAction func loginAction(_ sender: Any) {
        
        guard let user = userTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if (!user.isEmpty && !password.isEmpty){
            apiConnection.login(user: user, passWord: password)
            self.nextScreen(ViewId: Constants.kViewController )
        }else{
            creatingAlert()
        }
    }
    
}

