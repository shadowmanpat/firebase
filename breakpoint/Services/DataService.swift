//
//  DataService.swift
//  breakpoint
//
//  Created by macbook on 24/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users_ios")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference{
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference{
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String,Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete:  @escaping (_ status: Bool, _ error: Error?) -> ()) {
        if groupKey != nil {
            //send to group ref
            
        }else{
            REF_FEED.childByAutoId().updateChildValues(["content":message, "senderID": uid])
            sendComplete(true, nil)
        }
    }
    
    func getAllFeedMessages(handler: @escaping(_ messages: [Message])-> ()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshop) in
            guard let feedMessageSnapshop = feedMessageSnapshop.children.allObjects as? [DataSnapshot] else {return}
            for message in feedMessageSnapshop {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderID").value as! String
                
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func getUSerName(forUID uid: String, handler: @escaping (_ username: String) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnaphot) in
            guard let userSnapshot = userSnaphot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as!String)
                }
            }
        }
    }
    
    func getEmail(forSearchQuery: String, handler: @escaping (_ emailArray: [String]) -> ()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(forSearchQuery) && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
        }
        handler(emailArray)
    }
    
    func getIds(forUsernaems usernames: [String], handler: @escaping (_ uidArray: [String])->()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email){
                    idArray.append( user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func createGroupd(withTitle title: String, description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool)->()){
        
        REF_GROUPS.childByAutoId().updateChildValues(["title":title, "description":description,"members" :ids])
        handler(true)
        
    }
}


