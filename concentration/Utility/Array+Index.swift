//
//  Array+Index.swift
//  concentration
//
//  Created by Carly Nield on 9/10/20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int? { // of card has two parameters for readability. we use card internally.
        for index in 0..<self.count {
            if self[index].id == element.id {
                return index
            }
        }
        return nil
    }
}
