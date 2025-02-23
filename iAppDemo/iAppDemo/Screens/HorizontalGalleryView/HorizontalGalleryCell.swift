//
//  HorizontalGalleryCell.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI

struct HorizontalGalleryCell: View {
    private var item: HorizontalGalleryCellItem
    private var tapAction: (() -> ())?
    private let imageSize = CGSize(width: 80, height: 80)
    @ObservedObject private var imageLoader: AsyncImageLoader

    init(item: HorizontalGalleryCellItem, tapAction: (() -> ())?) {
        self.item = item
        self.tapAction = tapAction
        self.imageLoader = AsyncImageLoader(url: item.imageUrl,
                                            compressedImageSize: imageSize)
    }

    var body: some View {
        Button(action: {
            tapAction?()
        }) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 10)

                if let image = imageLoader.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize.width, height: imageSize.height)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Color.gray.frame(width: imageSize.width,
                                     height: imageSize.height)
                }

                Spacer()
                    .frame(height: 8)

                Text(item.title)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .lineLimit(2)

                Spacer()
            }
        }
        .onDisappear {
            imageLoader.cancel()
        }
    }
}

#Preview {
    if let imageUrl = URL(string: "https://live.staticflickr.com/65535/54341397917_6122100dbd_m.jpg") {
        let item = HorizontalGalleryCellItem(title: "White-backed Vulture", imageUrl: imageUrl)
        HorizontalGalleryCell(item: item, tapAction: nil)
            .frame(width:120, height: 140)
            .background(Color.orange)

    }
}
