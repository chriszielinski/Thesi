//
//  MarkdownIndent.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation

struct MarkdownIndent {

    enum IndentCharacter: String {
        case space = " "
        case tab = "\t"
        case none = ""

        init(matchSubstring: String?) {
            guard let indentCharacter = matchSubstring?.first else {
                self = .none
                return
            }
            self = IndentCharacter(rawValue: String(indentCharacter))!
        }
    }

    let character: IndentCharacter
    let count: Int

    var isCodeBlock: Bool {
        return (character == .tab) || (character == .space && count >= 4)
    }

    var stringValue: String {
        return String(repeating: character.rawValue, count: count)
    }

    init(matchSubstring: String?) {
        character = IndentCharacter(matchSubstring: matchSubstring)
        count = matchSubstring?.count ?? 0
    }

}
