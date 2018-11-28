//
//  ImageTests.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/23/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import XCTest

class ImageTests: ThesiTestCase {

    override var regexReplaceableClass: RegexReplaceable.Type {
        return MarkdownImage.self
    }

    func testCommonMarkImage() {
        ThesiTest("Thesi converts CommonMark Markdown image.",
                  test: "![Alternate text](http://google.com/images)")
    }

    func testCenterImage() {
        ThesiTest("Thesi does not center image.",
                  test: "!![Alternate text](http://google.com/images)",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text">
                            </p>
                            """)
    }

    func testImageWithWidth() {
        ThesiTest("Thesi does not set the width of the image.",
                  test: "![Alternate text](http://google.com/images, width=100px)",
                  expected: """
                            <img src="http://google.com/images" alt="Alternate text" width="100px">
                            """)
    }

    func testImageWithHeight() {
        ThesiTest("Thesi does not set the height of the image.",
                  test: "![Alternate text](http://google.com/images, height=100px)",
                  expected: """
                            <img src="http://google.com/images" alt="Alternate text" height="100px">
                            """)
    }

    func testImageWithWidthAndHeight() {
        ThesiTest("Thesi does not set the width and height of the image.",
                  test: "![Alternate text](http://google.com/images, width=100px, height=100px)",
                  expected: """
                            <img src="http://google.com/images" alt="Alternate text" width="100px" height="100px">
                            """)
    }

    func testImageWithHeightAndWidth() {
        ThesiTest("Thesi does not set the height and width of the image.",
                  test: "![Alternate text](http://google.com/images, height=100px, width=100px)",
                  expected: """
                            <img src="http://google.com/images" alt="Alternate text" width="100px" height="100px">
                            """)
    }

    func testCenterImageWithWidth() {
        ThesiTest("Thesi does not center and set the width of the image.",
                  test: "!![Alternate text](http://google.com/images, width=100px)",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" width="100px">
                            </p>
                            """)
    }

    func testCenterImageWithHeight() {
        ThesiTest("Thesi does not center and set the width of the image.",
                  test: "!![Alternate text](http://google.com/images, height=100px)",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" height="100px">
                            </p>
                            """)
    }

    func testCenterImageWithWidthAndHeight() {
        ThesiTest("",
                  test: "!![Alternate text](http://google.com/images, width=50px, height=200px)",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" width="50px" height="200px">
                            </p>
                            """)
    }

    func testCenterImageWithHeightAndWidth() {
        ThesiTest("",
                  test: "!![Alternate text](http://google.com/images, height=200px, width=50px)",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" width="50px" height="200px">
                            </p>
                            """)
    }

    func testCenterImageWithSpacedHeightAndWidth() {
        ThesiTest("",
                  test: "!![Alternate text](http://google.com/images, height=200 px, width=50 px)",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" width="50 px" height="200 px">
                            </p>
                            """)
    }

    func testCenterImageWithQuotedHeightAndWidth() {
        ThesiTest("",
                  test: "!![Alternate text](\"http://google.com/images\", height=\"200px\", width=\"50px\")",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" width="50px" height="200px">
                            </p>
                            """)
    }

    func testCenterWeirdImage() {
        ThesiTest("",
                  test: "!![Alternate text]( \"http://google.com/images\" ,  height = \"200px\"  , width = \"50px\"  )",
                  expected: """
                            <p align="center">
                                <img src="http://google.com/images" alt="Alternate text" width="50px" height="200px">
                            </p>
                            """)
    }
}
