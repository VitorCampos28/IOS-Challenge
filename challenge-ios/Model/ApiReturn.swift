//
//  ApiReturn.swift
//  challenge-ios
//
//  Created by Vitor Campos on 28/05/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import Foundation
//MARK: - ReturnApi

struct ReturnApiPizza: Codable {
    let id, name, imageUrl: String
    let rating: Int
    let priceP, priceM, priceG: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, imageUrl
        case rating
        case priceP, priceM, priceG
    }
}

