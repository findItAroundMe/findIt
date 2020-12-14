//
//  EditViewController.swift
//  findIt
//
//  Created by Eric Nguyen on 12/13/20.
//  Copyright © 2020 Eric Nguyen. All rights reserved.
//

import UIKit
import Parse

class EditViewController: UIViewController {

    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var weatherField: UITextField!
    @IBOutlet weak var foodField: UITextField!
    @IBOutlet weak var drinkField: UITextField!
    @IBOutlet weak var stayedField: UITextField!
    @IBOutlet weak var memoryField: UITextField!
    
    var location: String = ""
    var currObject:PFObject!
    var buttonPressed: Bool = false
    
       override func viewDidLoad() {
           super.viewDidLoad()
           LocationLabel.text = "Location: " + location
           
           let query = PFQuery(className: "Locations")
           query.includeKeys(["Location"])
           query.limit = 20
                         
           query.findObjectsInBackground() { (locations, error) in
               if locations != nil{
                   if let prelocations = locations {
                       for preexistinglocation in prelocations{
                           if(preexistinglocation["Location"] as! String == self.location){
                               if(preexistinglocation["hasDetails"] as! Bool == false) {
                                self.currObject = preexistinglocation
                               }
                               
                           }
                       }
                   }
               }
           }
       }
       
    
    @IBAction func onSubmit(_ sender: Any) {
        buttonPressed = true
        currObject["weather"] = weatherField.text
        currObject["Food"] = foodField.text
        currObject["Drink"] = drinkField.text
        currObject["Stayed"] = stayedField.text
        currObject["memories"] = memoryField.text
        currObject["hasDetails"] = true
        currObject.saveInBackground() { (success, error) in
            if success {
                print("saved!")
            } else {
                print("error!")
            }
        self.performSegue(withIdentifier: "finishDetailsSegue", sender: nil)

        
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if buttonPressed == true {
            let detailsViewController = segue.destination as! LocationDetailsViewController
            detailsViewController.location = self.location
        }
      
      
        
        
         
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
