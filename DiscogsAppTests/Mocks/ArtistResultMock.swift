//
//  ArtistResultMock.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

@testable import DiscogsApp

extension ArtistResult {
    static let artistA = ArtistResult(
        id: 1,
        type: "artist",
        userData: UserData(inWantlist: false, inCollection: false),
        masterId: nil,
        masterUrl: nil,
        uri: "/artist/1",
        title: "Artist A",
        thumb: "https://example.com/thumb1.jpg",
        coverImage: "https://example.com/cover1.jpg",
        resourceUrl: "https://api.discogs.com/artists/1",
        country: "US",
        year: "2023",
        format: ["CD"],
        label: ["Label 1"],
        genre: ["Rock"],
        style: ["Alternative"],
        barcode: ["1234567890"],
        community: CommunityData(want: 100, have: 50)
    )
    static let artistB = ArtistResult(
        id: 2,
        type: "artist",
        userData: UserData(inWantlist: true, inCollection: false),
        masterId: nil,
        masterUrl: nil,
        uri: "/artist/2",
        title: "Artist B",
        thumb: "https://example.com/thumb2.jpg",
        coverImage: "https://example.com/cover2.jpg",
        resourceUrl: "https://api.discogs.com/artists/2",
        country: "UK",
        year: "2022",
        format: ["Vinyl"],
        label: ["Label 2"],
        genre: ["Pop"],
        style: ["Synth-pop"],
        barcode: ["0987654321"],
        community: CommunityData(want: 200, have: 100)
    )
}
