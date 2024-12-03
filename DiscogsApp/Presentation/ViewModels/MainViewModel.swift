//
//  MainViewModel.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 1/12/24.
//

import Foundation
import Combine

@MainActor
class MainViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var artists: [ArtistResult] = []
    @Published var isLoading: Bool = false
    
    private let repository: ArtistRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: ArtistRepositoryProtocol = ArtistRepository()) {
        self.repository = repository
        setupSearchDebounce()
    }
    
    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newQuery in
                Task {
                    await self?.performSearch(query: newQuery)
                }
            }
            .store(in: &cancellables)
    }
    
    func performSearch(query: String) async {
        guard !query.isEmpty else {
            artists = []
            return
        }
        isLoading = true
        do {
            artists = try await repository.fetchArtists(query: query, page: 1)
        } catch {
            print("Error fetching artists: \(error.localizedDescription)")
            artists = []
        }
        isLoading = false
    }
}
