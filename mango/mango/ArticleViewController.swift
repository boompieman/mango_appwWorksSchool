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
    var tagAndTime = [Article]()
    var id: String?
    var a: Article?
    var b: Article?

 
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

                        self.a = Article(id: article.key, title: title, content:content , tag: tag, author:Author(id: authorId, email: authorEmail) , createdTime:createdTime)

                        if friendid == self.a!.author.id {
                            articlesArray.append(self.a!)
                         //   print("articleArray",articlesArray)
                        }
                   }
                 }
               }
            }) { (error) in
                print(error.localizedDescription)
        }
        
        
    }
    

    @IBAction func timeAndTab(_ sender: Any) {
        self.ref?.child("articles")
            .observeSingleEvent(of: .value, with: { (snapshot) in
          
            // Get user value
            if  let getartiles = snapshot.value as? [String:AnyObject]{
           
                for getarticle in getartiles {
                    //var article = Article()
                    guard let tag = getarticle.value["tag"] as? String  else{return}

                    guard let title = getarticle.value["title"] as? String
                        else { return}
     
                    guard let content = getarticle.value["content"] as? String else { return}

                    
                    guard let  author = getarticle.value["author"] as? [String:AnyObject] else{return}
                   // print(author)
                    guard let authorId = author["id"] as? String else{return}
                   // print(authorId)
                    guard    let authorEmail = author["email"] as? String else{return}
                   // print(authorEmail)
                    guard let createdTime = getarticle.value["createdTime"] as? Int else { return}
                    
                    self.a = Article(id: getarticle.key, title: title, content: content, tag: tag, author: Author(id: authorId, email: authorEmail), createdTime: createdTime)
                    
                    let date1 = Date(timeIntervalSince1970: TimeInterval(1523365200)) //2018年4月10日星期二 21:00:00
                    let date2 = Date(timeIntervalSince1970: TimeInterval(1523368800)) //2018年4月10日星期二 22:00:00
                    let articleDate = Date(timeIntervalSince1970: TimeInterval((self.a?.createdTime)!/1000))
             
                    
                    if self.a?.tag == "ios 生活"  &&
                        (articleDate > date1 &&  articleDate<date2)
                        {
                        print("time",self.a?.getTime())
//                        print("--------")
                        self.tagAndTime.append(self.a!)
                        self.tagAndTime = self.tagAndTime.sorted(by: {$0.createdTime>$1.createdTime})
                       print(self.tagAndTime)
                    }
                  }
                }
         
         }) { (error) in
            print(error.localizedDescription)
        }
      }
    }
    
   

