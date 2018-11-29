//
//  MarkdownUnderlineHeading.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import Regex

struct MarkdownUnderlineHeading {

    let markdownHeading: MarkdownHeading

    enum RegexGroupKey: String, CaseIterable {
        case indent
        case headingText
        case underline
    }

}

extension MarkdownUnderlineHeading: RegexReplaceable {

    //swiftlint:disable:next force_try
    static let regex = try! Regex(pattern: "^([ \t]*)([^#\n]+)\n[ \t]*([=-]+)",
                                  options: [.anchorsMatchLines],
                                  groupNames: RegexGroupKey.allRawValues)

    var replacementMarkdownString: String {
        return markdownHeading.replacementMarkdownString
    }

    init?(match: Match) {
        let indent = match.group(named: RegexGroupKey.indent.rawValue)

        // Note: Matches will never be nil because the regex capture groups are one or more.
        let headingText = match.group(named: RegexGroupKey.headingText.rawValue)!
        let underline = match.group(named: RegexGroupKey.underline.rawValue)!

        // Make sure it's a H1 or H2 heading.
        guard let markdownHeading = MarkdownHeading(indent: indent, headingText: headingText, underline: underline)
            else { return nil }
        self.markdownHeading = markdownHeading
    }

}
