//
//  GalleryDetailsImageView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 25.02.25.
//

import SwiftUI

struct GalleryDetailsImageView: View {
    @ObservedObject private var imageLoader: AsyncImageLoader
    @Binding private var imageOpacity: CGFloat
    @Binding private var imageHeight: CGFloat


    init(imageURL: URL, opacity: Binding<CGFloat>, imageHeight: Binding<CGFloat>) {
        self.imageLoader = AsyncImageLoader(url: imageURL)
        _imageHeight = imageHeight
        _imageOpacity = opacity
    }

    var body: some View {
        VStack {
            if let image = imageLoader.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageHeight)
                    .clipped()
                    .overlay(
                        .black.opacity(imageOpacity)
                    )
            } else {
                Color.gray
                    .frame(height: imageHeight)
                    .opacity(imageOpacity)
            }
            Spacer()
        }
        .onDisappear {
            imageLoader.cancel()
        }
    }
}
