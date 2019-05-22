//
//  PostItem.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 21/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import Foundation

struct PostItem : Codable {
    var userId: Int32
    var id: Int32
    var title: String
    var body: String
}
