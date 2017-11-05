//
//  Constants.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let appDelegate = UIApplication.shared.delegate as? AppDelegate

enum GoalType: String{
    case longTerm = "Long term"
    case sortTerm = "Short term"
}

//StoryBoard azonosítok
let CO_CREATE_GOAL_SB = "createGoalSB"
let CO_FINISH_GOAL_SB = "finishGoalSB"

//Cellák
let CO_GOAL_CELL = "goalCell"
