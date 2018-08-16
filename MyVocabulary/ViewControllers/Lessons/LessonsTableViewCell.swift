//
//  LessonsTableViewCell.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/7/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import SnapKit

class LessonsTableViewCell: UITableViewCell {

    let lessonView = LessonView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lessonView)
        lessonView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
