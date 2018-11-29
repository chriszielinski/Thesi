//
//  MarkdownCallout.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/22/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import Regex

struct MarkdownCallout {

    enum Callout: String, CaseIterable {
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

    let indent: MarkdownIndent
    let callout: Callout

    init(callout: Callout) {
        indent = .none
        self.callout = callout
    }

}

extension MarkdownCallout: RegexReplaceable {

    //swiftlint:disable:next force_try
    static let regex: Regex = try! Regex(pattern: "^([ \t]*)< *(\\w+) *> *",
                                         options: [.anchorsMatchLines, .useUnicodeWordBoundaries],
                                         groupNames: [])

    var replacementMarkdownString: String {
        let titleMarkdown = callout.usesTitle ? " **" + callout.name + ":**" : ""
        return "\(indent.stringValue)> \(callout.emoji)\(titleMarkdown) "
    }

    init?(match: Match) {
        indent = MarkdownIndent(matchSubstring: match.group(at: 1))
        let calloutCapture = match.group(at: 2)!

        // Make sure it isn't inside a code block.
        guard !indent.isCodeBlock,
            let callout = Callout(rawValue: calloutCapture.lowercased())
            else { return nil }

        self.callout = callout
    }

}
