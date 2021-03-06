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
    //MARK: - Outlet
    @IBOutlet weak var pizzaTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: - Variable
    var searchPizza: [ReturnApiPizza] = []
    var pizzas: [ReturnApiPizza] = []
    let disposeBag = DisposeBag()
    var apiConnection = ApiConnection()
    var nextScreenPizza: ReturnApiPizza?
    
    fileprivate enum Constants {
        static let kDetailViewControllerIdentifier = "PizzaDetailViewController"
        static let kErrorTitle = "DataError"
        static let kErrorMessage = "Data Error"
        static let kButtonOption = "OK"
        static let kIdCell = "pizzaCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        searchBar.delegate = self
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
        observablePizzas()
        
    }
    
    //MARK:- Observable
    func observablePizzas() {
        apiConnection.fetchPizzas().subscribe(onNext: { pizzaList in
            self.pizzas = pizzaList
            self.searchPizza = pizzaList
            self.pizzaTableView.reloadData()
            self.removeSpinner()
            
        }, onError:  {error in
            self.creatingAlert()
        }).disposed(by: disposeBag)
    }
    //MARK:- CreatingAlert
    func creatingAlert(){
        let alert = UIAlertController(title: Constants.kErrorTitle, message: Constants.kErrorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.kButtonOption, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

//MARK: - Extension
extension PizzaListViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count > 2 && !searchText.isEmpty){
            let searchTextLowerCase = searchText.lowercased()
            searchPizza = pizzas.filter({$0.name.lowercased().contains(searchTextLowerCase)})
        } else {
            searchPizza = pizzas
        }
        pizzaTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPizza.count
        
    }
    //MARK: - Update Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pizzaTableView.dequeueReusableCell(withIdentifier: Constants.kIdCell) as? PizzaTableViewCell else { return UITableViewCell()}
        let pizza = searchPizza[indexPath.row]
       
        cell.configCell(pizza: pizza)
        return cell
    }
    //MARK: - Click Event Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        nextScreenPizza = searchPizza[indexPath.row]
        
        guard let storyboard = self.storyboard, let navController = self.navigationController else { return }
        // Cria uma instancia da PizzaDetailViewController para acessar a variavel 'pizzaSelected'
        let pushScreen = storyboard.instantiateViewController(identifier:  Constants.kDetailViewControllerIdentifier) as PizzaDetailViewController
        // passa pra tela de detalhe a pizza selecionada
        pushScreen.pizzaSelected = nextScreenPizza
        // da push na stack da NavigationController
        navController.pushViewController(pushScreen, animated: true)
    }
}
