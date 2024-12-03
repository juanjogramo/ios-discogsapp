//
//  MainViewModelTests.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

@testable import DiscogsApp
import XCTest
import Combine

@MainActor
class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var mockRepository: MockArtistRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockArtistRepository()
        viewModel = MainViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testPerformSearch_Success() async {
        // Given
        let mockArtists = [
            ArtistResult.artistA,
            ArtistResult.artistB
        ]
        mockRepository.fetchArtistsResult = .success(mockArtists)
        
        // When
        await viewModel.performSearch(query: "Test")
        
        // Then
        XCTAssertEqual(viewModel.artists.count, 2)
        XCTAssertEqual(viewModel.artists.first?.title, "Artist A")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testPerformSearch_EmptyQuery() async {
        // Given
        await viewModel.performSearch(query: "")
        
        // Then
        XCTAssertTrue(viewModel.artists.isEmpty)
    }
    
    func testPerformSearch_Failure() async {
        // Given
        let mockError = URLError(.badServerResponse)
        mockRepository.fetchArtistsResult = .failure(mockError)
        
        // Then
        await viewModel.performSearch(query: "Test")
        
        // When
        XCTAssertTrue(viewModel.artists.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
}
