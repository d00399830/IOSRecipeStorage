//
//  RecipesViewController.swift
//  project2
//
//  Created by Stratton McDonald on 10/11/21.
//

import UIKit

class RecipesViewController: UITableViewController {
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func addNewRecipe(_ sender: UIBarButtonItem) {
        let newRecipe = RecipeStore.AllRecipes.createRecipe()
        
        if let index = RecipeStore.AllRecipes.allRecipes.firstIndex(of: newRecipe) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeStore.AllRecipes.allRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        let recipe = RecipeStore.AllRecipes.allRecipes[indexPath.row]
        let dateRec = recipe.dateCreated
        
        cell.nameField.text = recipe.name
        cell.dateLabel.text = "$\(dateFormatter.string(from: dateRec))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = RecipeStore.AllRecipes.allRecipes[indexPath.row]
            RecipeStore.AllRecipes.removeRecipe(recipe)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        RecipeStore.AllRecipes.moveRecipe(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65//UITableView.automaticDimension
        //tableView.estimatedRowHeight = 65
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showRecipe":
            if let row = tableView.indexPathForSelectedRow?.row {
                let recipe = RecipeStore.AllRecipes.allRecipes[row]
                let detailViewController = segue.destination as! IngredientsViewController
                detailViewController.recipe = recipe
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
