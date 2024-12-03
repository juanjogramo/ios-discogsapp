//
//  ArtistReleaseMock.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

@testable import DiscogsApp

extension ArtistRelease {
        static let mocks = [
            ArtistRelease(
                id: 1,
                artist: "Artist 1",
                mainRelease: 1001,
                resourceUrl: "https://api.discogs.com/releases/1001",
                role: "Main",
                thumb: "https://example.com/thumb1.jpg",
                title: "Album A",
                type: "Album",
                year: 2023,
                format: "Vinyl",
                label: "Label 1",
                status: "Accepted"
            ),
            ArtistRelease(
                id: 2,
                artist: "Artist 2",
                mainRelease: 1002,
                resourceUrl: "https://api.discogs.com/releases/1002",
                role: "Main",
                thumb: "https://example.com/thumb2.jpg",
                title: "Album B",
                type: "Album",
                year: 2022,
                format: "CD",
                label: "Label 2",
                status: "Accepted"
            ),
            ArtistRelease(
                id: 3,
                artist: "Artist 1",
                mainRelease: 1003,
                resourceUrl: "https://api.discogs.com/releases/1003",
                role: "Main",
                thumb: "https://example.com/thumb3.jpg",
                title: "Album C",
                type: "Album",
                year: 2023,
                format: "Digital",
                label: "Label 1",
                status: "Accepted"
            )
        ]
}
