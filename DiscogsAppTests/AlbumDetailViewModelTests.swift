//
//  AlbumDetailViewModelTests.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import XCTest
@testable import DiscogsApp

@MainActor
class AlbumDetailViewModelTests: XCTestCase {

    var viewModel: AlbumDetailViewModel!
    var mockRepository: MockArtistRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockArtistRepository()
        viewModel = AlbumDetailViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchAlbumDetails_Success() async {
        // Given
        let mockAlbumDetail = AlbumDetail(
            title: "Never Gonna Give You Up",
            id: 249504,
            artists: [AlbumDetail.Artist(id: 72872, name: "Rick Astley", resource_url: "https://api.discogs.com/artists/72872")],
            thumb: nil,
            community: nil,
            companies: nil,
            country: "UK",
            released: "1987",
            genres: ["Pop"],
            styles: ["Synth-pop"],
            tracklist: [
                AlbumDetail.Track(position: "A", title: "Never Gonna Give You Up", duration: "3:32")
            ],
            year: 1987
        )

        mockRepository.fetchAlbumDetailsResult = .success(mockAlbumDetail)

        // When
        await viewModel.fetchAlbumDetails(albumId: 249504)

        // Then
        XCTAssertNotNil(viewModel.album)
        XCTAssertEqual(viewModel.album?.title, "Never Gonna Give You Up")
        XCTAssertEqual(viewModel.album?.artists.first?.name, "Rick Astley")
        XCTAssertEqual(viewModel.album?.year, 1987)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchAlbumDetails_Failure() async {
        // Given
        let mockError = URLError(.badServerResponse)
        mockRepository.fetchAlbumDetailsResult = .failure(mockError)

        // When
        await viewModel.fetchAlbumDetails(albumId: 249504)

        // Then
        XCTAssertNil(viewModel.album)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "Failed to load album details: \(mockError.localizedDescription)")
    }

}
