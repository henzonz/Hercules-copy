//
//  SitUpViewController.swift
//  Hercules
//
//  Created by Patricia on 4/12/21.
//

import UIKit
import CoreMotion
import FirebaseDatabase
import AVFoundation

class SitUpViewController: UIViewController {
    
    var player: AVAudioPlayer!

    @IBOutlet weak var sitUpCount: UILabel!
    
    let motionManager = CMMotionManager()
    
    var counter = 0
    var tempCounter = 0
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGyro()

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
        ref.child("Workouts").childByAutoId().setValue("\(dateTimeString)             Sit Ups                \(counter)")
    }
    
    func myGyro() {
        if motionManager.isGyroAvailable {
            motionManager.deviceMotionUpdateInterval = 1;
            motionManager.startDeviceMotionUpdates()

            motionManager.gyroUpdateInterval = 0.3
            guard let currentQueue = OperationQueue.current else { return }
            motionManager.startGyroUpdates(to: currentQueue) { (gyroData, error) in

                // Do Something, call function, etc
                if let rotation = gyroData?.rotationRate {
                    if rotation.x < -2 {
                        //print ("\(rotation.x)")
                        self.tempCounter += 1
                        if self.tempCounter > 0 {
                            self.playSound(soundName: "PingSound")
                            self.counter += 1
                            self.tempCounter = 0
                        }
                        self.sitUpCount.text = "\(self.counter)"
                    
                    }
                    
                    
                }
            }
        }
    }
    
    func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }

}
