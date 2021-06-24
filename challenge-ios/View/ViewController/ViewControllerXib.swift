//
//  ViewControllerXib.swift
//  challenge-ios
//
//  Created by Vitor Natal on 22/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class ViewControllerXib: UIViewController {
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
        static let kButtonOK = "OK"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        
    }
    
    //MARK:- funcCreatingAlert
    func creatingAlert(){
        let alert = UIAlertController(title: Constants.kLoginError, message: Constants.kErrorLoginMessage , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.kButtonOK, style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    //MARK:- ClickButton
    @IBAction func loginAction(_ sender: Any) {
        
        guard let user = userTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if (!user.isEmpty && !password.isEmpty){
            apiConnection.login(user: user, passWord: password)
            self.navigationController?.pushViewController(PizzaListViewControllerXib(nibName: "PizzaListViewControllerXib", bundle: nil), animated: true)
        }else{
            creatingAlert()
        }
    }
    

}
