//
//  ArtistRow.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI

struct ArtistRow: View {
    let artist: ArtistResult

    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: artist.thumb))
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text(artist.title)
                .font(.headline)
        }
        .padding(.vertical, 5)
    }
}
