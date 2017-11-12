//
//  UNService.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 10..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import UserNotifications
class UNService: NSObject {
    
    
    private override init(){ }
    static let instance = UNService()
    
    
    //kell egy unCenter
    let unCenter = UNUserNotificationCenter.current()
    
    func scheduledNotification(date: DateComponents ){
        let content = UNMutableNotificationContent()
        //Felparaméterezni
        content.title = "Create goals!"
        content.body = "It is time to create goals!"
        content.sound = .default()
        
        //Attachment
        if let path = Bundle.main.path(forResource: "goal", ofType: "jpg") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "goal", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
 
        //Trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        //Request
        let request = UNNotificationRequest(identifier: "UserNotification.date", content: content, trigger: trigger)
        unCenter.add(request)
    }
 
    func authorize(){
        let options: UNAuthorizationOptions = [.alert, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print( error ?? "no un autharization error" )
            guard granted else{
                return
            }
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    func configure(){
        unCenter.delegate = self
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}
    

extension UNService: UNUserNotificationCenterDelegate{
    //background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("un did recieved")
        
        completionHandler()
    }
    //foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("un will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
        
    }
    
    
}

