//
//  PullUpViewController.swift
//  Hercules
//
//  Created by Patricia on 4/12/21.
//

import UIKit
import FirebaseDatabase
import AVFoundation

class PullUpViewController: UIViewController {

    @IBOutlet weak var pullUpCount: UILabel!
    
    var player: AVAudioPlayer!
    
    var counter = 0
    
    let ref = Database.database().reference()
    
    @IBAction func pullUpButtonPressed(_ sender: UIButton) {
        playSound(soundName: "PingSound")
        counter += 1
        pullUpCount.text = "\(counter)"
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
        ref.child("Workouts").childByAutoId().setValue("\(dateTimeString)             Pull Ups               \(counter)")
    }
    
    func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
}
