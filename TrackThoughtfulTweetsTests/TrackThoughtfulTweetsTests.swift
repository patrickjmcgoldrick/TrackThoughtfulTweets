//
//  TrackThoughtfulTweetsTests.swift
//  TrackThoughtfulTweetsTests
//
//  Created by dirtbag on 11/29/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import XCTest
@testable import TrackThoughtfulTweets

class TrackThoughtfulTweetsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimelineParser() {
        
        let expectation = self.expectation(description: "Testing Timeline Parser")
        
        let testBundle = Bundle(for: type(of: self))
        let filename = "homeTimeLine"

        let path = testBundle.path(forResource: filename, ofType: "json")
        XCTAssertNotNil(path, "\(filename) file not found")

        guard let cleanPath = path else { return }

        // convert into URL
        let url = NSURL.fileURL(withPath: cleanPath)
        do {
            // load json into Data object
            let data = try Data(contentsOf: url)

            XCTAssertNotNil(data, "Data came back nil")

            let parser = TimelineParser()

            parser.parse(data: data) { (tweets) in
                for tweet in tweets {
                    print(tweet.text)
                    if let url = tweet.entities?.media?.first?.media_url {
                        print ("\t\(url)")
                    }
                }
            
                //XCTAssertTrue(tweets[0].text == "pair of dice, lost", "Unexpected Data returned")
                expectation.fulfill()
            }
        
        } catch {
            assertionFailure("Error: " + error.localizedDescription)
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }
}
