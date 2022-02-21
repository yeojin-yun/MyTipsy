//
//  MyTipsyBrain.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/21.
//

import Foundation
import UIKit

struct MyTipsyBrain {
    var totalValue: Int?
    
    func getTotalValue(total: String) -> Int {
        let IntValue = Int(total) ?? 1
        return IntValue
    }

    
}
