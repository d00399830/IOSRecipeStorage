//
//  Ingredient.swift
//  project2
//
//  Created by Stratton McDonald on 10/24/21.
//

import UIKit

class Ingredient: Equatable, Codable {
    var name: String
    let amount: String
    
    init(name: String, amount: String) {
        self.name = name
        self.amount = amount //ingredient amount
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["granulated", "artifical", "vegan"]
            let nouns = ["flour", "sugar", "salt"]
            
            let amount = ["cups", "tablespoons", "gallons", "pounds"]
            let amountOf = ["2", "4", "7"]
            
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            
            let randomAmountLbl = amount.randomElement()!
            let randomAmountOf = amountOf.randomElement()!
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomAmount = "\(randomAmountOf) \(randomAmountLbl)"
            
            self.init(name: randomName, amount: randomAmount)
        } else {
            self.init(name: "", amount: "")
        }
    }
    
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name == rhs.name
            && lhs.amount == rhs.amount
    }
}
