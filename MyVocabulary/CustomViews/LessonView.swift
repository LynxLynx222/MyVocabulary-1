//
//  LessonOptionView.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/20/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class LessonView: UIView {
    
    var titleLabel = UILabel()
    var progressLabel = UILabel()
    var wordCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initLabels()
        initConstraints()
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func initLabels(){
        titleLabel.textColor = .appBlue
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.addSubview(titleLabel)
        progressLabel.textColor = .black
        progressLabel.textAlignment = .right
        self.addSubview(progressLabel)
        self.addSubview(wordCountLabel)
        wordCountLabel.textColor = .gray
        wordCountLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func initConstraints(){
        progressLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.right.equalTo(progressLabel.snp.left).inset(16)
        }
        wordCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
        }
    }
    
}
