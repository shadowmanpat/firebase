//
//  MeVC.swift
//  breakpoint
//
//  Created by macbook on 25/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        let logoutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
                    do {
                        try Auth.auth().signOut()
                        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                        self.present(authVC!, animated: true, completion:  nil)
                    } catch {
                        print (error)
                    }
              }
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp,animated: true,completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
