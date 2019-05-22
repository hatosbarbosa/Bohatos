//
//  PalavraDoDia.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 21/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import UIKit

class PalavraDaSemana : Post {
    var word: String!
    var description: String!
    
    init(postDate: String, word: String, description: String) {
        super.init(postDate: postDate)
        self.word = word
        self.description = description
    }
    
}
