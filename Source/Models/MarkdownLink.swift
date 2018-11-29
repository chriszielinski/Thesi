//
//  MarkdownLink.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import Regex

struct MarkdownLink {

    enum RegexGroupKey: String, CaseIterable {
        case indent
        case text
        case url
    }

    let indent: String
    let text: String
    let url: String

}

extension MarkdownLink: RegexReplaceable {

    //swiftlint:disable:next force_try
    static let regex = try! Regex(pattern: "( *)\\$\\[([^\\]]*)\\] *\\( *\"?([^\\)\"]*)\"? *\\)",
                                  options: [.dotMatchesLineSeparators],
                                  groupNames: RegexGroupKey.allRawValues)

    var replacementMarkdownString: String {
        return "\(indent)<a href=\"\(url)\" target=\"_blank\">\(text)</a>"
    }

    init?(match: Match) {
        indent = match.group(named: RegexGroupKey.indent.rawValue) ?? ""

        // Make sure it isn't inside a code block.
        guard indent.count < 4
            else { return nil }

        text = match.group(named: RegexGroupKey.text.rawValue) ?? ""
        url = match.group(named: RegexGroupKey.url.rawValue) ?? ""
    }

}
