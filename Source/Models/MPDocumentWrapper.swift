//
//  MPDocumentWrapper.swift
//  Thesi 🧝‍♀️
//
//  Created by Chris Zielinski on 11/23/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Cocoa

/// A class that provides a limited interface to a `MPDocument`.
class MPDocumentWrapper {

    /// The properties of a `MPDocument`.
    enum Property: String {
        case markdown
        case editor
        case highlighter
    }

    /// The methods of a `HGMarkdownHighlighter`.
    enum Highlighter: String {
        case clearHighlighting

        /// Returns the method's selector.
        var selector: Selector {
            return Selector(self.rawValue)
        }
    }

    /// The `MPDocument` that the receiver wraps.
    unowned let mpDocument: NSDocument

    /// The Markdown contents of the `MPDocument`.
    ///
    /// - Note: Use `updateEditorMarkdown(string:)` to set new Markdown contents.
    var markdown: String {
        //swiftlint:disable:next force_cast
        get { return value(forKey: .markdown) as! String }
        set { setValue(newValue, forKey: .markdown) }
    }

    /// Returns the `MPDocument`'s editor.
    var editor: NSTextView? {
        return value(forKey: .editor) as? NSTextView
    }

    /// Returns the `MPDocument`'s highlighter (`HGMarkdownHighlighter`).
    var highlighter: NSObject? {
        return value(forKey: .highlighter) as? NSObject
    }

    /// Creates a new wrapper.
    ///
    /// - Parameter mpDocument: The `MPDocument` to wrap.
    init(mpDocument: NSDocument) {
        self.mpDocument = mpDocument
    }

    private func value(forKey key: Property) -> Any? {
        return mpDocument.value(forKey: key.rawValue)
    }

    private func setValue(_ value: Any?, forKey key: Property) {
        mpDocument.setValue(value, forKey: key.rawValue)
    }

    /// Replaces the `MPDocument`'s Markdown content.
    ///
    /// Unlike setting the Markdown content directly, this method supports user undo-ing and refreshes the
    /// syntax highlighting.
    ///
    /// - Parameter string: The replacement Markdown string.
    func updateEditorMarkdown(to string: String) {
        if let textView = editor,
            textView.shouldChangeText(in: NSRange(location: 0, length: textView.string.utf16.count),
                                      replacementString: string) {
            clearEditorHighlighting()
            textView.string = string
            textView.didChangeText()
        } else {
            markdown = string
        }
    }

    /// Removes the editor's Markdown highlighting.
    func clearEditorHighlighting() {
        highlighter?.perform(Highlighter.clearHighlighting.selector)
    }

}
