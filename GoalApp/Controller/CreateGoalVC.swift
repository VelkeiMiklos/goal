//
//  CreateGoalVC.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import CoreData
class CreateGoalVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //Variables
    //Alapértelmezett goal típus
    var goalType: GoalType = .sortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        nextBtn.bindToKeyboard()
    }
  
}
//TextViewDelegate
extension CreateGoalVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
    }
}

//Actions
extension CreateGoalVC{
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        guard let goalDescription = goalTextView.text , goalTextView.text != "" &&  goalTextView.text != "What is your goal?" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter goal description", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: CO_FINISH_GOAL_SB) as? FinishGoalVC else { return }
        finishGoalVC.initData(goalDescription: goalDescription, goalType: goalType)
        presentDetail(finishGoalVC)
        
    }
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .sortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
}
