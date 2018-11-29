//
//  MarkdownCallout.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/22/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import Regex

enum MarkdownCallout: String, CaseIterable {
    case note
    case warning
    case `try`
    case important
    case fire
    case bug
    case why

    var usesTitle: Bool {
        switch self {
        case .fire:
            return false
        default:
            return true
        }
    }

    var name: String {
        return String(rawValue.first!).uppercased() + rawValue.dropFirst()
    }

    var emoji: String {
        switch self {
        case .note:
            return "📌"
        case .warning:
            return "⚠️"
        case .try:
            return "🎡"
        case .important:
            return "📣"
        case .fire:
            return "🔥"
        case .bug:
            return "🐞"
        case .why:
            return "🤔"
        }
    }

}

extension MarkdownCallout: RegexReplaceable {

    //swiftlint:disable:next force_try
    static let regex: Regex = try! Regex(pattern: "^( *)< *(\\w+) *> *",
                                         options: [.anchorsMatchLines, .useUnicodeWordBoundaries],
                                         groupNames: [])

    var replacementMarkdownString: String {
        let titleMarkdown = usesTitle ? " **" + name + ":**" : ""
        return "> \(emoji)\(titleMarkdown) "
    }

    init?(match: Match) {
        let indentCount = match.group(at: 1)?.count ?? 0
        // Make sure it isn't inside a code block.
        guard indentCount < 4,
            let calloutCaptureGroup = match.group(at: 2)
            else { return nil }

        self.init(rawValue: calloutCaptureGroup.lowercased())
    }

}
