//
//  MyButton.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import Foundation
import UIKit

class MyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, size: CGFloat) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont(name: "SongMyung-Regular", size: size)
        backgroundColor = UIColor.white
        setTitleColor(.darkGray, for: .normal)
        layer.cornerRadius = 20
        //layer.shadowRadius = 50
        layer.borderWidth = 2
        layer.shadowColor = UIColor.darkGray.cgColor
        //layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
