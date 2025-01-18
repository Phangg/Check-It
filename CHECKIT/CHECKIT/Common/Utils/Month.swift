//
//  Month.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

enum Month: String, CaseIterable {
    case Jan
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
    
    static func getMonth(for num: Int) -> Month {
        guard (1...12).contains(num) else {
            fatalError("잘못된 파라미터 : getMonth")
        }
        return Month.allCases[num - 1]
    }
}
