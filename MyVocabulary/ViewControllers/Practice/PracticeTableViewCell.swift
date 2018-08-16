//
//  PracticeTableViewCell.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/18/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {

    var leftLabel = UILabel()
    var rightLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftLabel.textAlignment = .right
        leftLabel.textColor = .black
        leftLabel.numberOfLines = 0
        rightLabel.textAlignment = .left
        rightLabel.textColor = .black
        rightLabel.numberOfLines = 0
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)

        leftLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(2).inset(8)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        rightLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(2).inset(8)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
