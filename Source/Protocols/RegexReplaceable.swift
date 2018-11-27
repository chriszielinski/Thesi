//
//  RegexReplaceable.swift
//  Thesi
//
//  Created by Chris Zielinski on 11/22/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import Regex

public protocol RegexReplaceable {
    static var regex: Regex { get }
    static func replaceAll(in markdownContent: inout String)

    var replacementMarkdownString: String { get }

    init?(match: Match)
}

public extension RegexReplaceable {
    static func replaceAll(in markdownContent: inout String) {
        markdownContent = regex.replaceAll(in: markdownContent, using: { (match) -> String? in
            return Self(match: match)?.replacementMarkdownString
        })
    }
}
