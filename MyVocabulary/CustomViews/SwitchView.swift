//
//  SwitchView.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class SwitchView: UIView {

    let titleLabel = UILabel()
    let switchView = UISwitch()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubviews(){
        [titleLabel, switchView, descriptionLabel].forEach(addSubview(_:))
    }
    
    private func setupSubviews(){
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupConstraints(){
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(switchView.snp.leading).offset(-16)
        }
        switchView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalTo(switchView.snp.leading).offset(-16)
        }
        
    }

}
