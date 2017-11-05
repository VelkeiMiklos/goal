//
//  FinishGoalVC.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import CoreData
class FinishGoalVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var pointsTxt: UITextField!
    
    @IBOutlet weak var createGoalBtn: UIButton!
    //Variable
    var goalDescription: String!
    var goalType: GoalType!
    var points: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTxt.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func initData(goalDescription: String, goalType: GoalType){
        self.goalDescription = goalDescription
        self.goalType = goalType
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalWasPressed(_ sender: Any) {
        
        if pointsTxt.text != "" &&  pointsTxt.text != "0"{
            self.saveGoal(completion: { (success) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Goal was not save", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            })
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please enter goal points", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        
    }
    
}

extension FinishGoalVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pointsTxt.text = ""
    }
}

extension FinishGoalVC{
    
    func saveGoal(completion: @escaping(_ isSaveSuccess: Bool) -> ()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = "\(goalType)"
        goal.goalProgress = Int32(pointsTxt.text!)!
        goal.goalCompletionValue = 0
        
        do {
            try managedContext.save()
            print("goal was save")
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.localizedDescription)")
            completion(false)
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
}

