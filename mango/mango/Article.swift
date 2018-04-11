//
//  Article.swift
//  mango
//
//  Created by 王安妮 on 2018/4/10.
//  Copyright © 2018年 MACBOOK. All rights reserved.
//

import Foundation

struct Article {
    var id: String
    var title: String
    var content: String
    var tag: String
    var author: Author
    var createdTime: Int
    
    
        

    func getTime() -> String{
        
        let date = Date(timeIntervalSince1970: TimeInterval(self.createdTime/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        let dateString =  dateFormatter.string(from: date)
       
        return dateString
      
       // let dateFormatter = DateFormatter()
        
        
        
    }
}
