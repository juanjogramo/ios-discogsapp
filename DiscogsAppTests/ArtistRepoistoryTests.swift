//
//  ArtistRepoistoryTests.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import XCTest
@testable import DiscogsApp

final class ArtistRepoistoryTests: XCTestCase {
    
    var sut: ArtistRepository?
    
    override func setUp() {
        super.setUp()
        sut = ArtistRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testFetchArtists() async throws {
        // Given
        let bandName = "Guns N' Roses"
        let page = 1
        // When
        let result = try await sut?.fetchArtists(
            query: bandName,
            page: page
        )
        // Then
        XCTAssertTrue(result?.count == 3, "The results count should be 3")
    }
    
    func testFetchArtistDetails() async throws {
        // Given
        let artistId: Int = 124535
        // When
        let result = try await sut?.fetchArtistDetails(artistId: artistId)
        // Then
        XCTAssertTrue(result?.id == artistId, "artistId should be 124535")
    }
    
    func testFetchArtistReleases() async throws {
        // Given
        let artistId: Int = 124535
        // When
        let result = try await sut?.fetchArtistReleases(artistId: artistId)
        // Then
        XCTAssertTrue(result?.count == 10, "Results count should be 3")
    }
    
    func testFetchAlbumDetails() async throws {
        // Given
        let albumId: Int = 124535
        // When
        let result = try await sut?.fetchAlbumDetails(albumId: albumId)
        // Then
        XCTAssertTrue(result?.id == albumId, "albumId should be 124535")
    }
    
}
