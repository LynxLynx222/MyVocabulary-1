//
//  LanguageTableViewCell.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/4/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    let languageView = LanguageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView(){
        contentView.addSubview(languageView)
        languageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(60)
        }
    }
}
