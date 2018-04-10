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
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ref = Database.database().reference()
        addFriend()
        
    }
    
    func addFriend() {
        
        let user = Auth.auth().currentUser
        self.ref?.child("users").child((user?.uid)!).child("friends").child("ZyissGZesFhDlRp4l6dPjIvEwag2").updateChildValues(["email":"pore0814@gmail.com"])
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
