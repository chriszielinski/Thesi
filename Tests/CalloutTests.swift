//
//  CalloutTests.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/23/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import XCTest

class CalloutTests: ThesiTestCase {

    override var regexReplaceableClass: RegexReplaceable.Type {
        return MarkdownCallout.self
    }

    func testCallout() {
        for callout in MarkdownCallout.allCases {
            ThesiTest("Thesi does not convert '\(callout.name)' callout.",
                      test: "<\(callout.rawValue)> This is a `\(callout.name)` callout.",
                      expected: "\(callout.replacementMarkdownString)This is a `\(callout.name)` callout.")
        }
    }

    func testLowercaseCallout() {
        ThesiTest("Thesi does not convert lowercase callout.",
                  test: "<bug> This is a bug.",
                  expected: "> 🐞 **Bug:** This is a bug.")
    }

    func testUppercaseCallout() {
        ThesiTest("Thesi does not convert uppercase callout.",
                  test: "<BUG> This is a bug.",
                  expected: "> 🐞 **Bug:** This is a bug.")
    }

    func testWeirdCallout() {
        ThesiTest("Thesi does not convert weird callout.",
                  test: "< Bug  > This is a bug.",
                  expected: "> 🐞 **Bug:** This is a bug.")
    }

    func testIndentedCallout() {
        ThesiTest("Thesi does not convert indented callout.",
                  test: " <Bug> This is a bug.",
                  expected: "> 🐞 **Bug:** This is a bug.")
    }

    func testIndentedWeirdCallout() {
        ThesiTest("Thesi does not convert indented, weird callout.",
                  test: "  < Bug  > This is a bug.",
                  expected: "> 🐞 **Bug:** This is a bug.")
    }

    func testCalloutInCodeBlock() {
        ThesiTest("Thesi converts callout in a code block.",
                  test: "    < Bug> This is a bug.")
    }

    func testCalloutInCodeVoice() {
        ThesiTest("Thesi converts callout in code voice.",
                  test: "`< Bug> This is a bug.`")
    }

}
