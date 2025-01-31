//
//  SwipedCellManager.swift
//  CHECKIT
//
//  Created by phang on 1/30/25.
//

import SwiftUI

final class SwipedCellManager: ObservableObject {
    @Published var currentlySwipedCellID: UUID?
    
    func setCellSwiped(_ id: UUID?) {
        currentlySwipedCellID = id
    }
    
    func resetSwipedCell() {
        currentlySwipedCellID = nil
    }
}
