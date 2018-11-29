//
//  LinkTests.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/28/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import Foundation
import XCTest

class LinkTests: ThesiTestCase {

    override var regexReplaceableClass: RegexReplaceable.Type {
        return MarkdownLink.self
    }

    func testLink() {
        ThesiTest("Thesi does not convert link.",
                  test: "$[Simple Link](https://google.com)",
                  expected: """
                            <a href="https://google.com" target="_blank">Simple Link</a>
                            """)
    }

    func testNewLineLink() {
        ThesiTest("Thesi does not convert link.",
                  test: "\n$[Simple Link](https://google.com)",
                  expected: """

                            <a href="https://google.com" target="_blank">Simple Link</a>
                            """)
    }

    func testWeirdLink() {
        ThesiTest("Thesi does not convert weird link.",
                  test: " $[ Simple Link ] (\"https://google.com\" )",
                  expected: " <a href=\"https://google.com\" target=\"_blank\"> Simple Link </a>")
    }

    func testCommonMarkLink() {
        ThesiTest("Thesi converts CommonMark link.",
                  test: "[Alternate text](http://google.com/images)")
    }

    func testLinkInCodeBlock() {
        ThesiTest("Thesi converts link in (spaced) code block.",
                  test: "    $[Alternate text](http://google.com/images)")
        ThesiTest("Thesi converts link in (tabbed) code block.",
                  test: "\t$[Alternate text](http://google.com/images)")
    }

    func testCommonMarkImage() {
        ThesiTest("Thesi converts CommonMark image to link.",
                  test: "![Alternate text](http://google.com/images)",
                  expected: "![Alternate text](http://google.com/images)")
    }

}
