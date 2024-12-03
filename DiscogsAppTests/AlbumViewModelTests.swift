//
//  AlbumViewModelTests.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import XCTest
@testable import DiscogsApp

@MainActor
class AlbumsViewModelTests: XCTestCase {
    var viewModel: AlbumsViewModel!
    var mockRepository: MockArtistRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockArtistRepository()
        viewModel = AlbumsViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchAlbums_Success() async {
        // Given
        mockRepository.fetchArtistReleasesResult = .success(ArtistRelease.mocks)

        // When
        await viewModel.fetchAlbums(for: 123)

        // Then
        XCTAssertEqual(viewModel.albums.count, 3)
        XCTAssertEqual(viewModel.albums.first?.title, "Album A")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchAlbums_Failure() async {
        // Given
        let mockError = URLError(.badServerResponse)
        mockRepository.fetchArtistReleasesResult = .failure(mockError)

        // When
        await viewModel.fetchAlbums(for: 123)

        // Then
        XCTAssertTrue(viewModel.albums.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "Failed to load albums: \(mockError.localizedDescription)")
    }

    func testAvailableYears() async {
        // Given
        mockRepository.fetchArtistReleasesResult = .success(ArtistRelease.mocks)

        // When
        await viewModel.fetchAlbums(for: 123)

        // Then
        XCTAssertEqual(viewModel.availableYears, ["2023", "2022"])
    }

    func testAvailableLabels() async {
        // Given
        mockRepository.fetchArtistReleasesResult = .success(ArtistRelease.mocks)

        // When
        await viewModel.fetchAlbums(for: 123)

        // Then
        XCTAssertEqual(viewModel.availableLabels, ["Label 1", "Label 2"])
    }

    func testFilteredAlbums_ByYear() async {
        // Given
        mockRepository.fetchArtistReleasesResult = .success(ArtistRelease.mocks)

        // When
        await viewModel.fetchAlbums(for: 123)
        let filteredAlbums = viewModel.filteredAlbums(year: "2023", label: nil)

        // Then
        XCTAssertEqual(filteredAlbums.count, 2)
        XCTAssertEqual(filteredAlbums.first?.title, "Album A")
    }

    func testFilteredAlbums_ByLabel() async {
        // Given
        mockRepository.fetchArtistReleasesResult = .success(ArtistRelease.mocks)

        // When
        await viewModel.fetchAlbums(for: 123)
        let filteredAlbums = viewModel.filteredAlbums(year: nil, label: "Label 1")

        // Then
        XCTAssertEqual(filteredAlbums.count, 2)
        XCTAssertEqual(filteredAlbums.first?.title, "Album A")
    }

    func testFilteredAlbums_ByYearAndLabel() async {
        // Given
        mockRepository.fetchArtistReleasesResult = .success(ArtistRelease.mocks)

        // When
        await viewModel.fetchAlbums(for: 123)
        let filteredAlbums = viewModel.filteredAlbums(year: "2023", label: "Label 1")

        // Then
        XCTAssertEqual(filteredAlbums.count, 2)
        XCTAssertEqual(filteredAlbums.first?.title, "Album A")
    }
}
