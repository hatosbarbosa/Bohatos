//
//  PostWithImage.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 23/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import UIKit

class PostWithImage: PostItem {
    var image:UIImage!
    
    override init()
    {
        image = UIImage(named: "Elbow")
        super.init()
        
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
