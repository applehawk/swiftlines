//
//  StructUtils.swift
//  Lines
//
//  Created by Hawk on 23/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation

extension Set {
    func randomElement() -> Element? {
        let n = Int(arc4random_uniform(UInt32(count)))
        return count == 0 ? nil : self[self.startIndex.advancedBy(n)]
    }
}