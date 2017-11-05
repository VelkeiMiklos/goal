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
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CO_GOAL_CELL, for: indexPath) as? GoalCell else { return UITableViewCell() }
        
        cell.configureCell(description: "Eeat salad twice a weak", type: goalType, goalProgress: 3)
        return cell
        
    }
}
