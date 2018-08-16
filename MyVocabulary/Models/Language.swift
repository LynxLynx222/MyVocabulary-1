//
//  Language.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/4/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

class Language: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var numberOfLessons = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String){
        self.init()
        self.title = title
    }
}
