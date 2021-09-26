//
//  LogViewController.swift
//  Hercules
//
//  Created by Henzon Zambrano on 4/12/21.
//

import UIKit
import FirebaseDatabase

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    let pullup = PullUpViewController()
    
    var logData = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        //Code to execute when child is added to "Workouts"
        //Take value and add to logData array
        
        //Retrieve Workouts and listen for changes
        databaseHandle = ref?.child("Workouts").observe(.childAdded, with: {(snapshot) in
            
            //Trying to convert value of data to string
            let log = snapshot.value as? String
            if let actualLog = log {
                //Append data to logData array
                self.logData.append(actualLog)
                
                //Reloads tableView
                self.tableView.reloadData()
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return logData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = logData[indexPath.row]
        
        return cell!
    }
    

}

//extension LogViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("you tapped")
//    }
//}
//
//extension LogViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return names.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.textLabel?.text = names[indexPath.row]
//
//        return cell
//    }
