//
//  RealmManager.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/17/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager{
    static let shared = RealmManager()
    let realm = try! Realm()
    
    func write(item: Object){
        try! realm.write {
            realm.add(item, update: true)
        }
    }
    
    func read(item: Object.Type, predicate: String) -> Results<Object>{
        let result = realm.objects(item).filter(predicate)
        return result
    }
    
    func delete(item: Object.Type, id: Int){
        try! realm.write {
            let result = realm.objects(item).filter("id = \(id)")
            print("delete result count \(result.count)")
            if !result.isInvalidated{
                realm.delete(result)
            }
        }
    }
    
    func deleteSequence(items: Results<Object>){
        try! realm.write {
            realm.delete(items)
        }
    }
}
