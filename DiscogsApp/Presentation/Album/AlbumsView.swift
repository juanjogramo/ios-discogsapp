//
//  AlbumsView.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI

struct AlbumsView: View {
    
    let artistId: Int
    @StateObject private var viewModel = AlbumsViewModel()
    @State private var selectedYear: String?
    @State private var selectedLabel: String?

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Picker("Year", selection: $selectedYear) {
                        Text("All Years").tag(String?.none)
                        ForEach(viewModel.availableYears, id: \.self) { year in
                            Text(year).tag(String?.some(year))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Picker("Label", selection: $selectedLabel) {
                    Text("All Labels").tag(String?.none)
                    ForEach(viewModel.availableLabels, id: \.self) { label in
                        Text(label).tag(String?.some(label))
                    }
                }
                .pickerStyle(.menu)
            }
            .padding(.horizontal)
            .padding(.top)
            List {
                ForEach(viewModel.filteredAlbums(year: selectedYear, label: selectedLabel)) { album in
                    NavigationLink(destination: AlbumDetailView(albumId: album.id)) {
                        AlbumRow(album: album)
                    }
                    
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Albums")
        .task {
            await viewModel.fetchAlbums(for: artistId)
        }
    }
}

struct AlbumRow: View {
    
    let album: ArtistRelease

    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: album.thumb))
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(album.title)
                    .font(.headline)
                if let year = album.year {
                    Text("Released: \(year)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let label = album.label {
                    Text("Label: \(label)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationView {
        AlbumsView(artistId: 12345535)
    }
}
