//
//  HorizontalGalleryCell.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI

struct HorizontalGalleryCell: View {
    private let item: HorizontalGalleryCellItem
    private let tapAction: (() -> ())?
    private let imageSize: CGSize = CGSize(width: 80, height: 80)
    private let topImageSpacing: CGFloat = 10.0
    private let bottomImageSpacing: CGFloat = 8.0
    private let imageCornerRadius: CGFloat = 10.0

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
                    .frame(height: topImageSpacing)

                if let image = imageLoader.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageSize.width, height: imageSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
                } else {
                    Color.gray
                        .frame(width: imageSize.width,
                               height: imageSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
                }

                Spacer()
                    .frame(height: bottomImageSpacing)

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
