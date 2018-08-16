//
//  PracticeViewModel.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

protocol PracticeViewModelDelegate: class{
    func reloadTableView()
}

class PracticeViewModel{
    
    private var words = [(Word, Hidden)]()
    private var leftSideHidden = false
    private var rightSideHidden = false
    
    weak var delegate: PracticeViewModelDelegate?
    
    init(lesson: Lesson) {
        getWords(lesson: lesson)
    }
    
    private func getWords(lesson: Lesson){
        let realm = try! Realm()
        let result = realm.objects(Word.self).filter(NSPredicate(format: "lessonID = %@", lesson.id ))
        for i in result{
            words.append((i, Hidden()))
        }
    }
    
    func getWordsCount() -> Int{
        return words.count
    }
    
    func getWord(row: Int) -> (Word, Hidden){
        return words[row]
    }
    
    func hideSide(side: Side){
        switch side {
        case .left:
            leftSideHidden = !leftSideHidden
            if rightSideHidden{
                rightSideHidden = !rightSideHidden
            }
            for i in words{
                i.1.hidden = leftSideHidden
                i.1.side = .left
            }
        case .right:
            rightSideHidden = !rightSideHidden
            if leftSideHidden{
                leftSideHidden = !leftSideHidden
            }
            for i in words{
                i.1.hidden = rightSideHidden
                i.1.side = .right
            }
        }
        delegate?.reloadTableView()
    }
    
    func showRow(row: Int){
        words[row].1.hidden = false
        delegate?.reloadTableView()
    }
}
