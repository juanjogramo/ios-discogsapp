//
//  ArtistDetail.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 1/12/24.
//

import Foundation

struct ArtistDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let profile: String?
    let images: [ArtistImage]?
    let members: [ArtistMember]?

    struct ArtistImage: Codable {
        let type: String
        let uri: String
        let uri150: String
    }

    struct ArtistMember: Codable, Identifiable {
        let id: Int
        let name: String
        let active: Bool
        let thumbnailUrl: String?

        enum CodingKeys: String, CodingKey {
            case id, name, active
            case thumbnailUrl = "thumbnail_url"
        }
    }
}
