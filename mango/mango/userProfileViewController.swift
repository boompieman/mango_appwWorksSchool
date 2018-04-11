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



class userProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var friendListView: UITableView!
    
    
    let ref: DatabaseReference = Database.database().reference()

    var currentUser = Author(id: (Auth.auth().currentUser?.uid)!, email: (Auth.auth().currentUser?.email)!)
    
    
    @IBOutlet weak var observerSwitch: UISwitch!
    
    var isObserverOpened = true
    
    var requestHandler: UInt?
    
    var requests: [Request] = [Request]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendListView.delegate = self
        self.friendListView.dataSource = self
        
        let nib = UINib(nibName: "FriendListViewCell", bundle: nil)
        self.friendListView.register(nib, forCellReuseIdentifier: "FriendListViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // open the listener
        
        
        notificationFromRequest()
    }
    
    
    func addFriend(from: Author) {
        
        let currentUser = Auth.auth().currentUser
        self.ref.child("users").child((currentUser?.uid)!).child("friends").child(from.id).updateChildValues(["email":from.email])
        
        self.ref.child("users").child(from.id).child("friends").child((currentUser?.uid)!).updateChildValues(["email": currentUser?.email])
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
        
        self.requests.removeAll()
        
        let request = ref.child("requests")
        request.observeSingleEvent(of: .value, with: {(snapShot) in
            
            let invitations = snapShot.value as? [String : AnyObject] ?? [:]
            
            
            for invitation in invitations {
                
                
                
                guard let invitationParsed = invitation.value as? [String: AnyObject] else {
                        return
                }
    
                guard let to = invitationParsed["to"], let from = invitationParsed["from"] else {
                    return
                }
                
                guard let toID = to["id"] as? String, let toEmail = to["email"] as? String, let fromID = from["id"] as? String, let fromEmail = from["email"] as? String else {
                    return
                }
                
                if toID == self.currentUser.id {

                    
                    let requestToMe = Request(id: invitation.key ,fromUser: Author(id: fromID, email: fromEmail), toUser: Author(id: toID, email: toEmail))
                    self.requests.append(requestToMe)
                    print("requests:",self.requests)
                    self.friendListView.reloadData()
//                    print("======")
//                    print("the invitation is from ", fromEmail)
                }
            }
        })
    }
    
    @IBAction func sendRequestTaped(_ sender: Any) {
        let friendRequest = RequestManager()
        
        
        
        friendRequest.sendRequest(self.currentUser, sendRequstTo: Author(id: "rn5Zag6r74cYm4DFQrVO3CHRWWf1", email: "faydee1280@gmail.com"))
    }
    
    func notificationFromRequest() {
        
        let request = Database.database().reference().ref.child("requests")
        
        
        
        
        self.requestHandler = request.observe(.childAdded, with: {(snapShot) in
            guard let request = snapShot.value as? [String: AnyObject] else {
                return
            }
            
            guard let to = request["to"], let from = request["from"] else {
                return
            }
            
            guard let toID = to["id"] as? String, let toEmail = to["email"] as? String, let fromID = from["id"] as? String, let fromEmail = from["email"] as? String else {
                return
            }
            
            
            
//
//            if self.isObserverOpened == false && toID == self.currentUser.id {
//
//                let newRequest = Request(id: snapShot.key, fromUser: Author(id: fromID, email: fromEmail), toUser: Author(id: toID, email: toEmail))
//                self.showRequest(request: newRequest)
//            }
//
//            self.isObserverOpened = false
            
//            print("=======")
//            print(toEmail)
//            print("=======")
//            print(self.isFirstObserve)
        })
    }
    
    func showRequest(request: Request) {
        // 建立一個提示框
        
        print("====show====")
        
        let alertController = UIAlertController(
            title: "想有朋友？",
            message: "這是一個來自\(request.fromUser.email)的交友邀請",
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        let yesAction = UIAlertAction(
            title: "好Ｒ，當朋友",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                self.ref.child("requests").child(request.id).removeValue()
                self.addFriend(from: request.fromUser)
        })
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(
            title: "滾喇～",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                self.ref.child("requests").child(request.id).removeValue()
        })
        alertController.addAction(noAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
    
    @IBAction func isObservedOpened(_ sender: Any) {
        
        let onState = observerSwitch.isOn
        
        if onState {
            notificationFromRequest()
        }
        else {
            ref.child("requests").removeObserver(withHandle: self.requestHandler!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendListViewCell = friendListView.dequeueReusableCell(withIdentifier: "FriendListViewCell") as! FriendListViewCell
        cell.invitationLabel.text = "這是一封來自\(self.requests[indexPath.row].fromUser.email)的交友邀情"
        
        cell.noButton.tag = indexPath.row
        cell.noButton.addTarget(self, action: #selector(rejectRequest(_ :)), for: .touchUpInside)
        
        cell.yesButton.tag = indexPath.row
        cell.yesButton.addTarget(self, action: #selector(approveRequest(_ :)), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func approveRequest(_ sender: UIButton) {
        
        ref.child("requests").child(self.requests[sender.tag].id).removeValue()
        addFriend(from: self.requests[sender.tag].fromUser)
        
        
        self.requests.remove(at: sender.tag)
        self.friendListView.reloadData()
    }
    
    @objc func rejectRequest(_ sender: UIButton) {
        
       
        ref.child("requests").child(self.requests[sender.tag].id).removeValue()
        
        self.requests.remove(at: sender.tag)
        self.friendListView.reloadData()
    }
}
