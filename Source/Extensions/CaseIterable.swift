//
//  CaseIterable.swift
//  Thesi
//
//  Created by Chris Zielinski on 11/22/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation

extension CaseIterable where Self: RawRepresentable {
    static var allRawValues: [Self.RawValue] {
        return allCases.map({ $0.rawValue })
    }
}
