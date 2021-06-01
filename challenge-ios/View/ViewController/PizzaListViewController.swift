//
//  PizzaListViewController.swift
//  challenge-ios
//
//  Created by Vitor Campos on 29/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import RxSwift


class PizzaListViewController: UIViewController {
    @IBOutlet weak var pizzaTableView: UITableView!
    
    var pizzas: [ReturnApiPizza] = []
    let disposeBag = DisposeBag()
    var apiConnection = ApiConnection()
    var nextScreenPizza: ReturnApiPizza?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
        observablePizzas()
        
    }
    
    //MARK:- Observable
    func observablePizzas() {
        apiConnection.fetchPizzas().subscribe(onNext: {observer in
            self.pizzas = observer
            self.pizzaTableView.reloadData()
            self.removeSpinner()
            
        }, onError:  {error in
            self.creatingAlert()
        }).disposed(by: disposeBag)
    }
    //MARK:- CreatingAlert
    func creatingAlert(){
        let alert = UIAlertController(title: "DataError", message: "Data Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

//MARK: - Extension
extension PizzaListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }
    //MARK: - Update Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pizzaTableView.dequeueReusableCell(withIdentifier: "pizzaCell") as! PizzaTableViewCell
        let pizza = pizzas[indexPath.row]
        cell.configCell(pizza: pizza)
        return cell
    }
    //MARK: - Click Event Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextScreenPizza = pizzas[indexPath.row]
        guard let storyboard = self.storyboard, let navController = self.navigationController else { return }
        let pushScreen = storyboard.instantiateViewController(identifier: "viewPizzaSize") as ViewPizzaSize
        pushScreen.pizzaSelected = nextScreenPizza
        navController.pushViewController(pushScreen, animated: true)

        
    }
}
