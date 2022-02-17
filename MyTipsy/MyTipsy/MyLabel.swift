//
//  MyLabel.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import Foundation
import UIKit
class MyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, size: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 0))
        font = UIFont(name: "SongMyung-Regular", size: size)
        layer.cornerRadius = 30
        text = title
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
