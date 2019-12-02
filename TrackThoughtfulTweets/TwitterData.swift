//
//  TwitterData.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 11/29/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var data: [User]
}

struct User: Codable {
    var name: String
    var username: String
    var description: String
    var profile_image_url: String
    var most_recent_tweet_id: String
}

struct FeedData: Codable {
    var data: [Tweet]
}

struct Tweet: Codable {
    var text: String
}

struct LastFMData: Codable {
    var tracks: [Track]?
}

struct Track: Codable {
    var track: [Song]?
}

struct Song: Codable {
    var name: String?
}
