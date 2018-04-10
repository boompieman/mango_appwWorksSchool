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
    var getFriendId = [String]()
    var id: String?
    
 
//    var articles :Article?
//    var author : Author?
     let userID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        // print(Auth.auth().currentUser?.uid)
          ref = Database.database().reference()
        //  getFriendUserId()
       // print("getfriend",getFriendId)
     findArticles(friendid: "rn5Zag6r74cYm4DFQrVO3CHRWWf1")
        

    }
    

    @IBAction func postArticle(_ sender: Any) {
      // let currentUser = Auth.auth()
        
        let id = self.ref?.child("articles").childByAutoId().key
        let timeInterval = Int(Date().timeIntervalSince1970 * 1000)
        
        let article = Article(id: id!, title: "ios 標題", content: "ios 內容", tag:"ios 生活" , author: Author(id:(Auth.auth().currentUser?.uid)!, email:(Auth.auth().currentUser?.email)!), createdTime: timeInterval)

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
    
//    func getFriendUserId()  {
//        var friends = [String]()
//
//        self.ref?.child("users")
//            .child(userID!)
//            .child("friends")
//            .observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//           let value = snapshot.value as? NSDictionary
//
//            guard let friendsKey = value?.allKeys as? [String] else {return}
//            friends = friendsKey
////            let user = User(username: username)
//            self.getFriendId = friends
//            print("key",friendsKey)
// //         print("friend",friends)
//
//           // self.findArticles(friends: friends)
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    func findArticles(friendid:String) {
        
        var articlesArray = [Article]() // 儲存比對後資料
        self.ref?.child("articles")
            
//                 .child("rn5Zag6r74cYm4DFQrVO3CHRWWf1")
//                 .child("author")
            
//
            .observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
            if   let articles = snapshot.value as? [String:AnyObject] {
                //  print(articles)
    
                
                 for article in articles {
                    if let eachArticle = article.value as? [String:AnyObject],
            
                        let title = eachArticle["title"] as? String,
                        let content = eachArticle["content"] as? String,
                        let tag = eachArticle["tag"] as? String,
                        let author = eachArticle["author"] as? [String:AnyObject],
                        let authorId = author["id"] as? String,
                        let authorEmail = author["email"] as? String,
                        let createdTime = eachArticle["createdTime"] as? Int
                        
                    {
               
                       // one.title
                        let a = Article(id: article.key, title: title, content:content , tag: tag, author:Author(id: authorId, email: authorEmail) , createdTime: createdTime)
print("author.id",a.author.id)
print("friend",friendid)
                        
                        if friendid == a.author.id {
                            articlesArray.append(a)
                            print("articleArray",articlesArray)
                        }
                        
                    }
                 
                }
               }
                
             //   guard let articleKey = value?.allKeys as? [String] else {return}
               
                //            let
//                user = User(username: username)
//                print("key",friendsKey)
//                //         print("friend",friends)
//                self.findArticles(friends: friends)
                
            }) { (error) in
                print(error.localizedDescription)
        }
        
        
    }
    

    

    
    
    
    
   
}
