//
//  ThesiControllerTests.swift
//  Thesi 🧝‍♀️ Tests
//
//  Created by Chris Zielinski on 11/24/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import XCTest

class ThesiControllerTests: XCTestCase {

    class MockMPDocument: NSDocument {
        @objc
        dynamic var markdown: String
        @objc
        dynamic var editor: NSTextView?

        init(markdownFilename: String) {
            let url = Bundle.init(for: ThesiControllerTests.self)
                .url(forResource: markdownFilename, withExtension: "md")!
            // swiftlint:disable:next force_try
            markdown = try! String(contentsOf: url)
        }
    }

    class MockDocumentController: NSDocumentController {
        let mockDocument: MockMPDocument

        override var currentDocument: NSDocument? {
            return mockDocument
        }

        init(currentDocument: MockMPDocument) {
            self.mockDocument = currentDocument

            super.init()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    func testIntegration() {

        let mockDocument = MockMPDocument(markdownFilename: "integration-test")
        _ = MockDocumentController(currentDocument: mockDocument)

        let expectedMarkdownURL = Bundle.init(for: ThesiControllerTests.self)
            .url(forResource: "integration-test-expected", withExtension: "md")!
        //swiftlint:disable:next force_try
        let expectedMarkdown = try! String(contentsOf: expectedMarkdownURL)

        XCTAssertTrue(ThesiController().run(sender: self), "Thesi `run(sender:)` failed.")

        XCTAssertTrue(mockDocument.markdown == expectedMarkdown,
                      "Thesi does not correctly format the integration test Markdown.")
    }

}
