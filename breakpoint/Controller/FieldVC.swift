//
//  FirstViewController.swift
//  breakpoint
//
//  Created by macbook on 24/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import UIKit

class FieldVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var mesageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedessagesArray) in
            self.mesageArray = returnedessagesArray.reversed()
            self.tableView.reloadData()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension FieldVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else {return UITableViewCell()}
        let image = UIImage(named: "defaultProfileImage")
        let message = mesageArray[indexPath.row]
        DataService.instance.getUSerName(forUID: message.senderId) { (returnedUserName) in
            cell.configureCell(profileImage: image!, email: returnedUserName, content: message.content)
            
        }
        
        return cell
    }
}

