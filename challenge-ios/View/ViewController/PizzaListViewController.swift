//
//  PizzaListViewController.swift
//  challenge-ios
//
//  Created by Thiago Pontes Lima on 29/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import RxSwift


class PizzaListViewController: UIViewController {
    @IBOutlet weak var pizzaTableView: UITableView!
    
    var pizzas: [ReturnApiPizza] = []
    let disposeBag = DisposeBag()
    var apiConnection = ApiConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
        observablePizzas()
    }
    
    //MARK:- observable
    func observablePizzas() {
        apiConnection.fetchPizzas().subscribe(onNext: {observer in
            self.pizzas = observer
            self.pizzaTableView.reloadData()
            
        }, onError:  {error in
            // Tratar erro aqui
            // Alert aqui
        }).disposed(by: disposeBag)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pizzaTableView.dequeueReusableCell(withIdentifier: "pizzaCell") as! PizzaTableViewCell
        let pizza = pizzas[indexPath.row]
        cell.configCell(pizza: pizza)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pizza = pizzas[indexPath.row]
    }
}
