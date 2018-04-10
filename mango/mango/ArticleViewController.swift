//
//  ArticleViewController.swift
//  mango
//
//  Created by 王安妮 on 2018/4/10.
//  Copyright © 2018年 MACBOOK. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ArticleViewController: UIViewController {
    
    var ref: DatabaseReference!
    var articles :Article?
    var author : Author?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // print(Auth.auth().currentUser?.uid)
        
        
      
       
    }
    

    @IBAction func postArticle(_ sender: Any) {
        let  id = ref.child("articls").childByAutoId().key
        author = Author(id: (Auth.auth().currentUser?.uid)!, email: (Auth.auth().currentUser?.email)!)
        articles = Article(id: id, title: "ios 標題", content: "ios 內容", tag:"ios 生活" , author: Author(id: (author?.id)!, email: (author?.email)!), createdTime: 20170814)
       
        
        ref = Database.database().reference()
        
        
        
        let key = ref.child("articles").childByAutoId().key
        let post = ["id": articles?.id,
                    "content":articles?.content ,
                    "creatTime": articles?.createdTime,
                    "tag":articles?.tag ]
                 
     
        ref.updateChildValues(childUpdates) as [String : Any]
        
    }
    

    

    
    
    
    
   
}
