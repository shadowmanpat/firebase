//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by macbook on 25/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var sendbutton: UIButton!
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textField.text != nil  {
            sendbutton.isEnabled = true
            DataService.instance.uploadPost(withMessage: textField.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil,sendComplete:
                {(isComplete, error) in
                    if isComplete {
                        self.sendbutton.isEnabled = true
                        self.dismiss(animated: true, completion: nil)
                        print("Message sent successfully")

                    }else{
                          self.sendbutton.isEnabled = true
                        print("There was an error!")
                    }
                    
            })
        }
    }
    @IBOutlet weak var closeBtnWasPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendbutton.bindToKeyboard()
        textField.bindToKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreatePostVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
