//
//  ViewController.swift
//  mango
//
//  Created by MACBOOK on 2018/4/10.
//  Copyright © 2018年 MACBOOK. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: "test@gmail.com", password: "123456") { (user, error) in
            if let user = user {
                print("user id: \(user.uid)")
                self.ref?.child("users").child(user.uid).setValue(["email": user.email])
                
//                let friend = ["id": "12345"]
//                
//                self.ref?.child("users").child(user.uid).child("friends").updateChildValues(friend)
                
                
//                self.ref?.child("users").child(user.uid).child("friends")
            }
            if let error = error {
                print("error: \(error)")
            }
        }
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: "test@gmail.com", password: "123456") { (user, error) in
            if let user = user {
                print("user id: \(user.uid)")
                self.performSegue(withIdentifier: "goToFriendPage", sender: self)
                
            }
            if let error = error {
                print("error: \(error)")
            }
        
        }

    }
}

