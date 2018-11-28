//
//  ThesiController.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/21/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Cocoa

@objc(ThesiController)
public class ThesiController: NSObject {

    static let regexReplaceableClasses: [RegexReplaceable.Type] = [
        MarkdownImage.self,
        MarkdownCallout.self
    ]

    @objc
    public var name: String {
        return "Thesi 🧝‍♀️"
    }

    @objc(run:)
    public func run(sender: Any) -> Bool {
        guard let currentDocument = NSDocumentController.shared.currentDocument
            else { return false }

        let mpDocument = MPDocumentWrapper(mpDocument: currentDocument)
        var mutableMarkdown = mpDocument.markdown

        format(markdownString: &mutableMarkdown)
        mpDocument.updateEditorMarkdown(to: mutableMarkdown)

        return true
    }

    func format(markdownString: inout String) {
        for regexReplaceable in ThesiController.regexReplaceableClasses {
            regexReplaceable.replaceAll(in: &markdownString)
        }
    }
}
