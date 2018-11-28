//
//  ThesiTestCase.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/23/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import XCTest

class ThesiTestCase: XCTestCase {
    var regexReplaceableClass: RegexReplaceable.Type {
        fatalError("Should be implemented by a subclass.")
    }

    /// Asserts that the result of `replaceAll(in:)` on the `regexReplaceableClass` is equal to an expected
    /// Markdown string.
    ///
    /// - Parameters:
    ///   - message: A description of the failure.
    ///   - markdown: The Markdown string to input.
    ///   - output: The expected Markdown string output. If `nil`, the input Markdown string is used.
    func ThesiTest(_ message: String, test markdown: String, expected output: String? = nil) {
        // swiftlint:disable:previous identifier_name
        let expectedMarkdown = output ?? markdown
        var testMarkdown = markdown

        regexReplaceableClass.replaceAll(in: &testMarkdown)

        let failureMessage = """
            \(message)

            Result:
            "\(testMarkdown)"

            Expected Output:
            "\(expectedMarkdown)"
            """
        XCTAssertTrue(testMarkdown == expectedMarkdown, failureMessage)
    }
}
