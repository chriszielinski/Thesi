//
//  MarkdownImage.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/22/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import Regex

struct MarkdownImage {
    //swiftlint:disable force_try
    static let regex = try! Regex(pattern: "^( *)!(!)?\\[(.+?)\\] *\\( *\"?(.+?)\"? *(,.+)?\\)",
                                  options: [.anchorsMatchLines],
                                  groupNames: RegexGroupKey.allRawValues)
    static let widthRegex = try! Regex(pattern: "width *= *\"?([^,\"]+)\"?",
                                       options: [.caseInsensitive],
                                       groupNames: [])
    static let heightRegex = try! Regex(pattern: "height *= *\"?([^,\"]+)\"?",
                                        options: [.caseInsensitive],
                                        groupNames: [])
    //swiftlint:enable force_try

    enum RegexGroupKey: String, CaseIterable {
        case indent
        case centerAlign
        case alternateText
        case url
        case properties
    }

    let indent: String
    let isCentered: Bool
    let alternateText: String
    let url: String
    var width: String?
    var height: String?

    init?(match: Match) {
        indent = match.group(named: RegexGroupKey.indent.rawValue) ?? ""

        // Make sure it isn't inside a code block.
        guard indent.count < 4
            else { return nil }

        isCentered = match.group(named: RegexGroupKey.centerAlign.rawValue) != nil
        alternateText = match.group(named: RegexGroupKey.alternateText.rawValue) ?? ""
        url = match.group(named: RegexGroupKey.url.rawValue) ?? ""

        if let properties = match.group(named: RegexGroupKey.properties.rawValue) {
            width = MarkdownImage.widthRegex.findFirst(in: properties)?.group(at: 1)
            height = MarkdownImage.heightRegex.findFirst(in: properties)?.group(at: 1)
        }

        // Make sure it's not a CommonMark Markdown image.
        guard isCentered || width != nil || height != nil
            else { return nil }
    }
}

extension MarkdownImage: RegexReplaceable {
    var replacementMarkdownString: String {
        var imageHTML = "<img src=\"\(url)\" alt=\"\(alternateText)\""

        if let width = width {
            imageHTML += " width=\"\(width)\""
        }

        if let height = height {
            imageHTML += " height=\"\(height)\""
        }

        imageHTML += ">"

        if isCentered {
            return """
            \(indent)<p align="center">
            \(indent)    \(imageHTML)
            \(indent)</p>
            """
        } else {
            return indent + imageHTML
        }
    }
}
