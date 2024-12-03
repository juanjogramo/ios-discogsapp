//
//  CachedAsyncImage.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    let url: URL?
    @StateObject private var loader = CachingImageLoader()
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color.gray)
            }
        }
        .task {
            if let url = url {
                await loader.loadImage(from: url)
            }
        }
    }
}
