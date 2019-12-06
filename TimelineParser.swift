//
//  TimelineParser.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/6/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

class TimelineParser {
    
    func parse(data: Data, parsed: @escaping ([TimelineData]) -> Void) {

        // background the loading / parsing elements
        DispatchQueue.global(qos: .userInitiated).async {

            print (data.description)

            do {
                // create decoder
                let jsonDecoder = JSONDecoder()

                // decode json into structs
                let timelineData = try jsonDecoder.decode([TimelineData].self, from: data)

                parsed(timelineData)

            } catch {
                print ("Error Parsing ClueData JSON: \(error.localizedDescription)")
            }
        }
    }
    
}
