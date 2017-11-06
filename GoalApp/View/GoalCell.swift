//
//  GoalCell.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(goal: Goal){
        self.goalDescriptionLbl.text = goal.goalDescription
        self.typeLbl.text = goal.goalType
        self.goalProgressLbl.text = "\(goal.goalCompletionValue)"
        
        //Ha a kitűzött goal pontot eléri akkor megjelenik a képernyőn
        if goal.goalCompletionValue == goal.goalProgress{
           completeView.isHidden = false
        }else{
            completeView.isHidden = true
        }
        
    }

}
