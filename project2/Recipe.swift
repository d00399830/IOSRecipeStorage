//
//  Recipe.swift
//  project2
//
//  Created by Stratton McDonald on 10/11/21.
//

import UIKit

class Recipe: Equatable, Codable {
    var name: String
    let dateCreated: Date
    var allIngredients = [Ingredient]()
    
    var ingredientArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("ingredients.plist")
    }()
    
    init(name: String) {
        do {
            let data = try Data(contentsOf: ingredientArchiveURL)
            let unarchiver = PropertyListDecoder()
            let ingredients = try unarchiver.decode([Ingredient].self, from: data)
            allIngredients = ingredients
        } catch {
            print("Error reading in saved items: \(error)")
        }
        
        self.name = name
        self.dateCreated = Date() //ingredient amount
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["instant", "slow-cooked", "roasted"]
            let nouns = ["casserole", "spaghetti", "steak"]
            
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            
            self.init(name: randomName)
        } else {
            self.init(name: "")
        }
    }
    
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name
            && lhs.dateCreated == rhs.dateCreated
    }
    
    @discardableResult func createIngredient() -> Ingredient {
        let newIngredient = Ingredient(random: true)
        allIngredients.append(newIngredient)
        return newIngredient
    }
    
    func removeIngredient(_ ingredient: Ingredient) {
        if let index = allIngredients.firstIndex(of: ingredient) {
            allIngredients.remove(at: index)
        }
    }
    
    func moveIngredient(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedIngredient = allIngredients[fromIndex]
        allIngredients.remove(at: fromIndex)
        allIngredients.insert(movedIngredient, at: toIndex)
    }
    
    @objc func saveChanges() -> Bool {
        print("Saving items to: \(ingredientArchiveURL)")
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allIngredients)
            try data.write(to: ingredientArchiveURL, options: [.atomic])
            print("Saved all of the ingredients")
            return true
        } catch let encodingError{
            print("Error encoding all ingredients: \(encodingError)")
            return false
        }
    }
}
