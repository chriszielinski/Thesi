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
    static let regex = try! Regex(pattern: "\\$\\[([^\\]]*)\\] *\\( *\"?([^\\)\"]*)\"? *\\)",
                                  options: [.dotMatchesLineSeparators],
                                  groupNames: RegexGroupKey.allRawValues)

    enum RegexGroupKey: String, CaseIterable {
        case text
        case url
    }

    let text: String
    let url: String

    init?(match: Match) {
        text = match.group(named: RegexGroupKey.text.rawValue) ?? ""
        url = match.group(named: RegexGroupKey.url.rawValue) ?? ""
    }
}

extension MarkdownLink: RegexReplaceable {
    var replacementMarkdownString: String {
        return "<a href=\"\(url)\" target=\"_blank\">\(text)</a>"
    }
}
