//
//  HashHeadingTests.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import XCTest

class HashHeadingTests: ThesiTestCase {

    override var regexReplaceableClass: RegexReplaceable.Type {
        return MarkdownHashHeading.self
    }

    func testOneHashHeading() {
        ThesiTest("Thesi does not convert # heading.",
                  test: "# Heading 1",
                  expected: """
                            Heading 1
                            =========
                            """)
    }

    func testTwoHashHeading() {
        ThesiTest("Thesi does not convert ## heading.",
                  test: "## Heading 2",
                  expected: """
                            Heading 2
                            ---------
                            """)
    }

    func testMinimumHashHeading() {
        ThesiTest("Thesi does not format minimum hash heading.",
                  test: """
                        # H
                        """,
                  expected: """
                            H
                            =
                            """)
    }

    func testIndentedOneHashHeading() {
        ThesiTest("Thesi does not convert # heading.",
                  test: "  # Heading 1",
                  expected: """
                              Heading 1
                              =========
                            """)
    }

    func testIndentedTwoHashHeading() {
        ThesiTest("Thesi does not convert ## heading.",
                  test: "  ## Heading 2",
                  expected: """
                              Heading 2
                              ---------
                            """)
    }

    func testNotHeading() {
        ThesiTest("Thesi converts non-heading.",
                  test: "This should not be converted # Heading")
    }

    func testHashtag() {
        ThesiTest("Thesi converts just a hashtag.",
                  test: "#Hashtag.")
        ThesiTest("Thesi converts hashtag.",
                  test: "This is a #Hashtag.")
    }

    func testHeadingInCodeBlock() {
        ThesiTest("Thesi converts heading in (spaced) code block.",
                  test: "    # Heading")
        ThesiTest("Thesi converts heading in (tabbed) code block.",
                  test: "\t# Heading")
    }

    func testMixedHeading() {
        ThesiTest("Thesi does not convert mixed heading.",
                  test: """
                        # Heading 1
                        ======
                        """,
                  expected: """
                            Heading 1
                            =========
                            """)
    }

}
