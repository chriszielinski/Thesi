//
//  MarkdownHeading.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation

struct MarkdownHeading {

    let indent: MarkdownIndent
    let heading: Heading
    let text: String

    enum Heading: String {
        case heading1 = "="
        case heading2 = "-"

        var underlineCharacter: Character {
            return Character(self.rawValue)
        }

        init?(hashes: String) {
            switch hashes.count {
            case 1:
                self = .heading1
            case 2:
                self = .heading2
            default:
                return nil
            }
        }

        init?(underline: String) {
            guard let underlineFirstCharacter = underline.first
                else { return nil }
            self.init(rawValue: String(underlineFirstCharacter))
        }
    }

    var replacementMarkdownString: String {
        return """
               \(indent.stringValue)\(text)
               \(indent.stringValue)\(String(repeating: heading.underlineCharacter, count: text.count))
               """
    }

    init?(indent: String?, hashes: String, headingText: String) {
        self.indent = MarkdownIndent(matchSubstring: indent)

        guard !self.indent.isCodeBlock, let heading = Heading(hashes: hashes)
            else { return nil }

        self.heading = heading
        self.text = headingText
    }

    init?(indent: String?, headingText: String, underline: String) {
        // Make sure the heading text isn't just whitespace/empty.
        guard !headingText.trimmingCharacters(in: .whitespaces).isEmpty
            else { return nil }

        self.indent = MarkdownIndent(matchSubstring: indent)

        guard !self.indent.isCodeBlock, let heading = Heading(underline: underline)
            else { return nil }

        self.heading = heading
        self.text = headingText
    }

}
