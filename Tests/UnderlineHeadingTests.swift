//
//  UnderlineHeadingTests.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import XCTest

class UnderlineHeadingTests: ThesiTestCase {

    override var regexReplaceableClass: RegexReplaceable.Type {
        return MarkdownUnderlineHeading.self
    }

    func testFormatHeading1() {
        ThesiTest("Thesi does not format underline heading 1.",
                  test: """
                        Heading 1
                        ====
                        """,
                  expected: """
                            Heading 1
                            =========
                            """)
    }

    func testFormatHeading2() {
        ThesiTest("Thesi does not format underline heading 2.",
                  test: """
                        Heading 2
                        ---
                        """,
                  expected: """
                            Heading 2
                            ---------
                            """)
    }

    func testIndentedHeading() {
        ThesiTest("Thesi does not format indented underline heading.",
                  test: """
                          Heading 1
                          ====
                        """,
                  expected: """
                              Heading 1
                              =========
                            """)
    }

    func testFormattedHeading1() {
        ThesiTest("Thesi does format an already formatted underline heading 1.",
                  test: """
                        Heading 1
                        =========
                        """)
    }

    func testFormattedHeading2() {
        ThesiTest("Thesi does format an already formatted underline heading 2.",
                  test: """
                        Heading 2
                        ---------
                        """)
    }

    func testNonHeading() {
        ThesiTest("Thesi does not format underline heading 1.",
                  test: """
                        Heading 1

                        ===
                        """)
    }

    func testHeadingInCodeBlock() {
        ThesiTest("Thesi does format underline heading in (spaced) code block.",
                  test: """
                            Heading 1
                            ====
                        """)
        ThesiTest("Thesi does format underline heading in (tabbed) code block.",
                  test: """
                        \tHeading 1
                        \t====
                        """)
    }

}
