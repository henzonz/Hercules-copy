//
//  PushUpViewController.swift
//  Hercules
//
//  Created by Patricia on 4/12/21.
//

import UIKit
import FirebaseDatabase
import AVFoundation

class PushUpViewController: UIViewController {

    @IBOutlet weak var pushUpCount: UILabel!
    
    var player: AVAudioPlayer!
    
    let device = UIDevice.current
    
    var counter = 0
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proximitySensor()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        //Gets current date and time
        let currentDate = Date()
        
        //Initializes the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yyyy"
        
        //Gets the date and time String from the date object
        let dateTimeString = formatter.string(from: currentDate)
        
        //Creates new id under Workouts and gives it a value.
        ref.child("Workouts").childByAutoId().setValue("\(dateTimeString)             Push Ups             \(counter)")
    }
    
    func proximitySensor() {
        device.isProximityMonitoringEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged), name: Notification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: nil)
    }
    
    @objc func proximityChanged(notification: Notification) {
        if let device = notification.object as? UIDevice {
            
            
            
            if device.proximityState {
                playSound(soundName: "PingSound")
                counter += 1
                self.pushUpCount.text = "\(counter)"
            }
            
        }
        
        
        
    }
    
    func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }

}
