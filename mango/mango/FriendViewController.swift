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

class FriendViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        print(ref)
        
        create_friend()
        
        
//        print(Auth.auth().currentUser?.uid)
        // Do any additional setup after loading the view.
    }
    
    func create_friend() {
        let userID = Auth.auth().currentUser?.uid
//        let key = ref.child("friends").childByAutoId().key
        let friendID = "Friend1"
        self.ref.child("friends").child(userID!).child(friendID).setValue(["friendName": "Sam",
                                                          "email":"sam@gmail.com"])
        
//        print(key)
        
//        let friend = ["id": "userID",
//                      "email": "email@gmail.com" ]
        
        
        
//        let post = ["uid": userID,
//                    "author": username,
//                    "title": title,
//                    "body": body]
        
//        let childUpdates = ["/posts/\(key)": post,
//                            "/user-posts/\(userID)/\(key)/": post]
//        ref.updateChildValues(childUpdates)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
