//
//  LessonOptionViewModel.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

class LessonOptionViewModel{
    var lesson: Lesson!
    
    init(lesson: Lesson){
        self.lesson = lesson
    }
    
    func getLesson() -> Lesson{
        return lesson
    }
    
    func reloadLesson(){
        let realm = try! Realm()
        let result = realm.objects(Lesson.self).filter(NSPredicate(format: "id = %@", lesson.id))
        lesson = result.first
    }
    
    func getLessonID() -> String{
        return lesson.id
    }
    
    
}
