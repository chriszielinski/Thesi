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

    let indent: MarkdownIndent
    let text: String
    let url: String

}

extension MarkdownLink: RegexReplaceable {

    //swiftlint:disable:next force_try
    static let regex = try! Regex(pattern: "([ \t]*)\\$\\[([^\\]]*)\\] *\\( *\"?([^\\)\"]*)\"? *\\)",
                                  options: [.dotMatchesLineSeparators],
                                  groupNames: RegexGroupKey.allRawValues)

    var replacementMarkdownString: String {
        return "\(indent.stringValue)<a href=\"\(url)\" target=\"_blank\">\(text)</a>"
    }

    init?(match: Match) {
        indent = MarkdownIndent(matchSubstring: match.group(named: RegexGroupKey.indent.rawValue))

        // Make sure it isn't inside a code block.
        guard !indent.isCodeBlock
            else { return nil }

        text = match.group(named: RegexGroupKey.text.rawValue) ?? ""
        url = match.group(named: RegexGroupKey.url.rawValue) ?? ""
    }

}
