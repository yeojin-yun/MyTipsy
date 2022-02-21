//
//  MyTipsyBrain.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/21.
//

import Foundation
import UIKit

struct MyTipsyBrain {
    //var totalValue: Int?
    
    func getTotalValue(total: String) -> Int {
        let IntValue = Int(total) ?? 1
        return IntValue
    }

    func getDecimalValue(_ value: Int, _ people: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1,000,000
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
        
        let result = value / people
        
        let safeNumber = formatter.string(for: result) ?? ""
        return safeNumber + "원"
        
//        guard let safeNumber = formatter.string(for: result) else { return true }
//        return safeNumber
    }
    
}
