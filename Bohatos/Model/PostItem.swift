//
//  PostItem.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 21/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import Foundation

class PostItem : Codable {
    var word: String
    var description: String
    var date:String
    
    
    init() {
        self.word = "word"
        self.description = "description"
        self.date = "date"
    }
}


/*
 [{'repeat(200,200)':
 {
 "word": '{{lorem(1,"words")}}',
 "description": '{{lorem(1,"sentences")}}',
 "date": '{{moment(this.date(new Date(2014, 0, 1), new Date())).format("l")}}'
 }  }
 ]
 
 
 
 */
