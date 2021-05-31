//
//  ApiConnection.swift
//  challenge-ios
//
//  Created by Vitor Campos on 28/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.

import Alamofire
import Foundation
import RxSwift

class ApiConnection{
    
    let loginUrl = "https://p3teufi0k9.execute-api.us-east-1.amazonaws.com/v1/signin"
    let pizzaUrl = "https://p3teufi0k9.execute-api.us-east-1.amazonaws.com/v1/pizza"
    //var credential = ["email": "user@xds.com.br", "password": "223344"]
    
    //MARK: - Login
    public func login(user: String, passWord: String){
        let params = createLoginParams(user: user, pass: passWord)
        _ = AF.request(loginUrl, method: .post,parameters: params).responseJSON{
            data in
            print(data)
        }
    }
    
    //MARK: - PizzaReturn
    public func fetchPizzas() -> Observable<[ReturnApiPizza]>{
        return Observable.create{ observer -> Disposable in
            let task = AF.request(self.pizzaUrl).responseJSON(completionHandler: {(data) in
                do {
                    let pizzas = try JSONDecoder().decode([ReturnApiPizza].self, from: data.data!)
                    observer.onNext(pizzas)
                } catch {
                    observer.onError(error)
                }
            })
            task.resume()
            return Disposables.create {
            task.cancel()
            }
        }
    }
    
    //MARK: - CreatingLoginParams
    private func createLoginParams(user: String, pass: String) -> [String : String] {
        return ["email": user, "password": pass]
    }
}
