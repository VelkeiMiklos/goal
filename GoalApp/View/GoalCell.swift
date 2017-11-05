//
//  GoalCell.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(description: String, type: GoalType, goalProgress: Int){
        self.goalDescriptionLbl.text = description
        self.typeLbl.text = type.rawValue
        self.goalProgressLbl.text = "\(goalProgress)"
    }

}
