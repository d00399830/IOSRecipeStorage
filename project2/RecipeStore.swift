//
//  RecipeStore.swift
//  project2
//
//  Created by Stratton McDonald on 10/11/21.
//

import UIKit

class RecipeStore {
    
    static let AllRecipes = RecipeStore()
    
    var allRecipes = [Recipe]()
    
    let recipeArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("recipes.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: recipeArchiveURL)
            let unarchiver = PropertyListDecoder()
            let recipes = try unarchiver.decode([Recipe].self, from: data)
            allRecipes = recipes
        } catch {
            print("Error reading in saved items: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    @discardableResult func createRecipe() -> Recipe {
        let newRecipe = Recipe(random: true)
        allRecipes.append(newRecipe)
        return newRecipe
    }
    
    func removeRecipe(_ recipe: Recipe) {
        if let index = allRecipes.firstIndex(of: recipe) {
            allRecipes.remove(at: index)
        }
    }
    
    func moveRecipe(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedRecipe = allRecipes[fromIndex]
        allRecipes.remove(at: fromIndex)
        allRecipes.insert(movedRecipe, at: toIndex)
    }
    
    @objc func saveChanges() -> Bool {
        print("Saving items to: \(recipeArchiveURL)")
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allRecipes)
            try data.write(to: recipeArchiveURL, options: [.atomic])
            print("Saved all of the recipes")
            return true
        } catch let encodingError{
            print("Error encoding all recipes: \(encodingError)")
            return false
        }
    }
}
