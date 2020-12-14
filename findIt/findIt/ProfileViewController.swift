//
//  ProfileViewController.swift
//  findIt
//
//  Created by Eric Nguyen on 12/13/20.
//  Copyright © 2020 Eric Nguyen. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //emailLabel.text = PFUser.current()?.object(forKey: "email") as! String
        //nameLabel.text = PFUser.current()?.object(forKey: "username") as! String
        
        let query = PFQuery(className: "Locations")
        query.limit = 20
                      
        query.findObjectsInBackground() { (locations, error) in
            if locations != nil{
                if let prelocations = locations {
                    for preexistinglocation in prelocations{
                        self.locationLabel.text! += "\n     -"
                        self.locationLabel.text! += (preexistinglocation["Location"] as? String)!
                    }
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(_ sender: Any) {
            PFUser.logOut()
            let main = UIStoryboard(name: "Main", bundle:nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "MainHomePage")
            
            let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            
            delegate.window?.rootViewController = loginViewController
            
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
