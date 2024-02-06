//
//  ViewController.swift
//  Rich_Push_Notifications
//
//  Created by Vishal on 05/02/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController{
    
    var content = UNMutableNotificationContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func btnTapped(_ sender:UIButton){
        print("btnTapped called---")
        scheduleLocalNotification()
    }
    
    //MARK: Notification Creation
    func scheduleLocalNotification() {
        // Notification Content
        
        content.title = "Zomato"
        content.subtitle = "🍕 Savor the Supreme Pizza Sensation! 🌟"
        content.body = "Dive into a world of culinary ecstasy with our Supreme Pizza – a symphony of flavors meticulously crafted for pizza enthusiasts. Picture a delectable medley of premium ingredients: succulent pepperoni, savory sausage, vibrant bell peppers, tantalizing mushrooms, and luscious mozzarella, all harmonizing on a perfect, golden crust."
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // content Image
        let imageUrl = Bundle.main.url(forResource: "pizza", withExtension: "jpeg")
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageUrl!, options: [:])
        content.attachments = [attachment]
        
        // Notification Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let identifier = "localNotification"
        
        // Notification Request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Notification Actions
        let likeAction = UNNotificationAction(identifier: "Like", title: "Like",options: .foreground)
        
        let replyAction = UNNotificationAction(identifier: "Reply", title: "Reply",options: .foreground)
        
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete",options: .destructive)
        
        let category = UNNotificationCategory(identifier: content.categoryIdentifier, actions: [likeAction, replyAction, deleteAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // adding Request
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    // MARK: Will present method
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Push notification received in foreground.")
        completionHandler([.alert, .sound, .badge])
    }
    
    
}

extension ViewController: UNUserNotificationCenterDelegate{
    
    //MARK: didReceive Method
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive called---")
        let content = response.notification.request.content
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let notificationDetailVC = storyboard.instantiateViewController(withIdentifier: "ntfDetailVC") as? notificationDetailViewController {
            print("notificationDetailViewController founded")
            notificationDetailVC.ntfTitle = content.title
            notificationDetailVC.ntfSubtitle = content.subtitle
            notificationDetailVC.ntfDetailTextView = content.body
            
            if let attachment = content.attachments.first, attachment.identifier == "image" {
                let imageUrl = attachment.url
                if let imageData = try? Data(contentsOf: imageUrl) {
                    notificationDetailVC.ntfImage = UIImage(data: imageData)
                } else {
                    print("Error loading image data")
                }
            }
            navigationController?.pushViewController(notificationDetailVC, animated: true)
        }
    }
}
