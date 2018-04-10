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
    
    var ref: DatabaseReference?
//    var articles :Article?
//    var author : Author?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // print(Auth.auth().currentUser?.uid)
        
          ref = Database.database().reference()

    }
    

    @IBAction func postArticle(_ sender: Any) {


        
      // let currentUser = Auth.auth()
        
        let id = self.ref?.child("articles").childByAutoId().key
        
        let article = Article(id: id!, title: "ios 標題", content: "ios 內容", tag:"ios 生活" , author: Author(id:(Auth.auth().currentUser?.uid)!, email:(Auth.auth().currentUser?.email)!), createdTime: 20179814)

        let post =
        [
            "title": article.title,
            "content":article.content ,
            "tag":article.tag,
            "createdTime": article.createdTime
        ] as [String : Any]

        
        let author = ["id": article.author.id, "email": article.author.email]

            self.ref?.child("articles").child(id!).setValue(post)
        self.ref?.child("articles").child(id!).child("author").updateChildValues(author)

    }
    

    

    
    
    
    
   
}
