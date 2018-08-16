//
//  LanguageView.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/4/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
class LanguageView: UIView {
    
    var titleLabel: UILabel!
    var lessonsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appBlue
        initLabels()
        initConstraints()
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func initLabels(){
        titleLabel = UILabel()
        titleLabel.textColor = .white
        self.addSubview(titleLabel)
        lessonsLabel = UILabel()
        lessonsLabel.textColor = .white
        lessonsLabel.textAlignment = .right
        self.addSubview(lessonsLabel)
    }
    
    private func initConstraints(){
        lessonsLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.trailing.equalTo(lessonsLabel.snp.leading).inset(16)
        }
    }
    
}
