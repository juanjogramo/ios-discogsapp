//
//  MainView.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $viewModel.searchQuery)
                    .background(Color(.systemBackground))
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                    Spacer()
                } else if viewModel.artists.isEmpty {
                    VStack {
                        Spacer()
                        Text("Search for an artist to see results.")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                } else {
                    List(viewModel.artists) { artist in
                        NavigationLink(destination: ArtistDetailView(artistId: artist.id)) {
                            ArtistRow(artist: artist)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Search Artists")
        }
    }
}

#Preview {
    MainView()
}
