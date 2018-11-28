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
    //swiftlint:disable:next force_try
    static let regex = try! Regex(pattern: "( *)\\$\\[([^\\]]*)\\] *\\( *\"?([^\\)\"]*)\"? *\\)",
                                  options: [.dotMatchesLineSeparators],
                                  groupNames: RegexGroupKey.allRawValues)

    enum RegexGroupKey: String, CaseIterable {
        case indent
        case text
        case url
    }

    let indent: String
    let text: String
    let url: String

    init?(match: Match) {
        indent = match.group(named: RegexGroupKey.indent.rawValue) ?? ""

        // Make sure it isn't inside a code block.
        guard indent.count < 4
            else { return nil }

        text = match.group(named: RegexGroupKey.text.rawValue) ?? ""
        url = match.group(named: RegexGroupKey.url.rawValue) ?? ""
    }
}

extension MarkdownLink: RegexReplaceable {
    var replacementMarkdownString: String {
        return "<a href=\"\(url)\" target=\"_blank\">\(text)</a>"
    }
}