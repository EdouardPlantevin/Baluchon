//
//  Currency.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

struct Rates: Decodable {
    let rates: [String: Double]
}
