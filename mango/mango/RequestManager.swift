//
//  RequestViewController.swift
//  
//
//  Created by MACBOOK on 2018/4/10.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RequestManager {
    
    let request = Database.database().reference().ref.child("requests")
    
    var currentUser = Author(id: (Auth.auth().currentUser?.uid)!, email: (Auth.auth().currentUser?.email)!)
    
    func getRequestID() -> String {
        
        return request.childByAutoId().key
    }
    
    
    func sendRequest(_ from: Author, sendRequstTo to: Author) {
        
        let requestID = getRequestID()
        
        let fromUser = ["id": from.id, "email": from.email]
        let toUser = ["id": to.id, "email": to.email]
        
        let childUpdates = ["/from":fromUser,
                            "/to":toUser]
        
        request.child(requestID).updateChildValues(childUpdates)
    }
}

