//
//  ViewController.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import CoreData
class Goals: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    //Variables
    //Alapértelmezett goal típus
    var goalType: GoalType = .sortTerm
    //Célok elmentése
    var goalArray = [Goal]()
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadData()
        self.tableView.reloadData()
    }
    
    
    //Functions
    func reloadData(){
        self.loadGoals { (success) in
            if success{
                if self.goalArray.count > 0 {
                    self.tableView.isHidden = false
                    
                }else{
                    self.tableView.isHidden = true
                }
            }
        }
    }
    
}

//Actions
extension Goals{
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: CO_CREATE_GOAL_SB) as? CreateGoalVC else { return }
        presentDetail(createGoalVC)
    }
    
}

// TableView
extension Goals: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CO_GOAL_CELL, for: indexPath) as? GoalCell else { return UITableViewCell() }
        
        let goal = goalArray[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    // Engedélyezni kell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            self.deleteGoal(indexPath: indexPath)
            self.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let addAction = UITableViewRowAction(style: .normal, title: "1 Point", handler: { (action, indexPath) in
            self.addPoint(indexPath: indexPath)
            //Sorok újra betöltése az adatváltozás miatt
            tableView.reloadRows(at: [indexPath], with: .automatic)
        })
        
        addAction.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.6528410316, blue: 0.1888206005, alpha: 1)
        return [deleteAction, addAction]
    }
}

//Core data
extension Goals{
    
    //Adatok betöltése
    func loadGoals(completion: @escaping(_ isSuccess: Bool)->()){
        
       guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
            goalArray =    try  managedContext.fetch(fetchRequest)
            completion(true)
        }catch{
            print("Could not load. \(error), \(error.localizedDescription)")
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            completion(false)
        }
    }
    
    // Adat törlése
    func deleteGoal(indexPath: IndexPath){
           guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
            let goal = goalArray[indexPath.row]
 
            managedContext.delete(goal)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)

        }
    }
    //Hozzá adni egy pontot
    func addPoint(indexPath: IndexPath){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = goalArray[indexPath.row]
        
        if goal.goalCompletionValue < goal.goalProgress{
            goal.goalCompletionValue = goal.goalCompletionValue + 1
        }
        else{
            return
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}
