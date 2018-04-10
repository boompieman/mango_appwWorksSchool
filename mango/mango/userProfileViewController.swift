//
//  FriendViewController.swift
//  mango
//
//  Created by 王安妮 on 2018/4/10.
//  Copyright © 2018年 MACBOOK. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class userProfileViewController: UIViewController {
    
    
    
    
    let ref: DatabaseReference = Database.database().reference()

    var currentUser = Author(id: (Auth.auth().currentUser?.uid)!, email: (Auth.auth().currentUser?.email)!)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // open the listener
        notificationFromRequest()
        
    }
    
    
    func addFriend() {
        
        let user = Auth.auth().currentUser
    self.ref.child("users").child((user?.uid)!).child("friends").child("rn5Zag6r74cYm4DFQrVO3CHRWWf1").updateChildValues(["email":"faydee1220@gmail.com"])
    }
    
    
    @IBAction func friendListTapped(_ sender: Any) {
        
        let friend = self.ref.child("users").child(currentUser.id).child("friends")
        
        friend.observe(.value, with: {(snapShot) in
            
            guard let friends = snapShot.value as? [String:AnyObject] else {
                return
            }
            for friend in friends {
                
                guard let email = friend.value["email"] as? String else {
                    return
                }
                print(email)
            }
        })
    }
    
    @IBAction func friendInvitationsTapped(_ sender: Any) {
        
        let request = ref.child("requests")
        request.observe(.value, with: {(snapShot) in
            
            let invitations = snapShot.value as? [String : AnyObject] ?? [:]
            for invitation in invitations {
                
//                print("======")
//                print(invitation)
                
                guard let invitationParsed = invitation.value as? [String: AnyObject] else {
                        return
                }
                
//                print("======")
//                print(invitationParsed["to"])
                
                guard let to = invitationParsed["to"], let from = invitationParsed["from"] else {
                    return
                }
                
                guard let toID = to["id"] as? String, let toEmail = to["email"] as? String, let fromID = from["id"] as? String, let fromEmail = from["email"] as? String else {
                    return
                }
                
                if toID == self.currentUser.id {
                    print("======")
                    print("the invitation is from ", fromEmail)
                }
            }
        })
    }
    
    @IBAction func addFriendTaped(_ sender: Any) {
//        addFriend()
        
        let friendRequest = Request()
        friendRequest.sendRequest(self.currentUser, sendRequstTo: Author(id: "rn5Zag6r74cYm4DFQrVO3CHRWWf1", email: "faydee@gmail.com"))
    }
    
    func notificationFromRequest() {
        
        let request = Database.database().reference().ref.child("requests")
        
        request.observe(.childAdded, with: {(snapShot) in
            print("----This is request --------")
            guard let request = snapShot.value as? [String: AnyObject] else {
                print("--------- error -----")
                
                return
                
            }
            
                print("=======")
            
                print(request)
                print("=======")
        })
    }
}
