//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by macbook on 26/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import UIKit
import Firebase
class CreateGroupsVC: UIViewController {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var emailSearchText: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBAction func cloaseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var emailArray = [String]()
    var choosenArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchText.delegate = self
        emailSearchText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        doneBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    @objc func textFieldDidChange() {
        if emailSearchText.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchText.text!) { (emailArray) in
                self.emailArray = emailArray
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func doenBtnPressed(_ sender: Any) {
        DataService.instance.getIds(forUsernaems: choosenArray) { (idsArray) in
            var userIDs = idsArray
            userIDs.append( (Auth.auth().currentUser?.uid)!)
            
            DataService.instance.createGroupd(withTitle: self.titleTxt.text!, description: self.descriptionTxt.text!, forUserIds: userIDs, handler: { (groupCreated) in
                if groupCreated {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("group failed to create")
                }
            })
        }
      
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
    }
 
    

}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
      
        cell.configureCell(profileIemge: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !choosenArray.contains(cell.emailLbl.text!){
            choosenArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = choosenArray.joined(separator: ", ")
             doneBtn.isHidden = false
        }else {
            choosenArray = choosenArray.filter({ $0 != cell.emailLbl.text!})
            if choosenArray.count >= 1 {
                groupMemberLbl.text = choosenArray.joined(separator: ", ")
                groupMemberLbl.text = " add member to your grop"
                 doneBtn.isHidden = true
            }
        }
        
    }
}

extension CreateGroupsVC: UITextFieldDelegate{
    
    
}
