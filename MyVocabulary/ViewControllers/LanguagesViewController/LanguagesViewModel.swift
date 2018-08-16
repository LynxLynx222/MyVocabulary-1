//
//  LanguageViewModel.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol LanguagesViewModelDelegate: class{
    func reloadTableView()
}

class LanguagesViewModel{
    
    private var languages = [Language]()
    private var colors = [UIColor]()
    
    weak var delegate: LanguagesViewModelDelegate?
    
    func getLanguagesCount() -> Int{
        return languages.count
    }
    
    func getLanguage(row: Int) -> Language{
        return languages[row]
    }
    
    func getColor(row: Int) -> UIColor{
        return colors[row]
    }
    
    func addLanguage(language: Language){
        languages.append(language)
        setColors(count: languages.count)
        RealmManager.shared.write(item: language)
        delegate?.reloadTableView()
    }
    
    func getLanguages(){
        let realm = try! Realm()
        let result = realm.objects(Language.self)
        languages.removeAll()
        for i in result{
            languages.append(i)
        }
        setColors(count: languages.count)
        delegate?.reloadTableView()
    }
    
    private func setColors(count: Int){
        guard count > 0 else {return}
        colors.removeAll()
        var colorIndex = 0
        for _ in 0...count-1{
            switch colorIndex{
            case 0:
                colors.append(.appBlue)
            case 1:
                colors.append(.appRed)
            case 2:
                colors.append(.appYellow)
            case 3:
                colors.append(.appGreen)
            default:
                continue
            }
            colorIndex += 1
            if colorIndex > 3{
                colorIndex = 0
            }
        }
    }
    
}
