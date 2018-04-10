//
//  RequestViewController.swift
//  
//
//  Created by MACBOOK on 2018/4/10.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RequestViewController: UIViewController {
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

