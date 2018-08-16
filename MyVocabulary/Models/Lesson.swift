//
//  Lesson.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/17/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

class Lesson: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var languageID = ""
    @objc dynamic var title = ""
    @objc dynamic var isAlphabet = false
    @objc dynamic var numberOfWords = 0
    @objc dynamic var quizCompleted = 0
    @objc dynamic var quizForeignCompleted = 0
    @objc dynamic var testCompleted = 0
    @objc dynamic var testForeignCompleted = 0
    @objc dynamic var completed = 0
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(languageID: String, title: String){
        self.init()
        self.languageID = languageID
        self.title = title
    }
}
