//
//  LocationDetailsViewController.swift
//  findIt
//
//  Created by Eric Nguyen on 12/13/20.
//  Copyright © 2020 Eric Nguyen. All rights reserved.
//

import UIKit
import Parse

class LocationDetailsViewController: UIViewController {

    

    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var FoodLabel: UILabel!
    @IBOutlet weak var DrinkLabel: UILabel!
    @IBOutlet weak var StayLabel: UILabel!
    @IBOutlet weak var MemoryLabel: UILabel!
    var location: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationLabel.text = "Location: " + location
        
        let query = PFQuery(className: "Locations")
        query.limit = 20
                      
        query.findObjectsInBackground() { (locations, error) in
            if locations != nil{
                if let prelocations = locations {
                    for preexistinglocation in prelocations{
                        if(preexistinglocation["Location"] as! String == self.location){
                            self.WeatherLabel.text! += (preexistinglocation["weather"] as? String)!
                            self.FoodLabel.text! += (preexistinglocation["Food"] as? String)!
                            self.DrinkLabel.text! += (preexistinglocation["Drink"] as? String)!
                            self.StayLabel.text! += (preexistinglocation["Stayed"] as? String)!
                            self.MemoryLabel.text! += (preexistinglocation["memories"] as? String)!
                        }
                    }
                }
            }
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
