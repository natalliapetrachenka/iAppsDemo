//
//  GalleryDetailsView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import CoreApiClient
import SwiftUI

struct GalleryDetailsView: View {
    @ObservedObject private var viewModel: GalleryDetailsViewModel
    @ObservedObject private var imageLoader: AsyncImageLoader
    @State private var imageOpacity: CGFloat = 0
    @State private var isPlayerPresented: Bool = false

    private let maxImageOpacity: CGFloat = 0.7

    private let imageScreenHeightPercent: CGFloat  = 0.45
    private let galleryDetailsContentTopPadding: CGFloat = 8.0

    private let bottomBarHeight: CGFloat = 100.0

    @State private var isExpanded: Bool = false

    private let audioPlayerHeightPercent: CGFloat = 0.45
    private let minPlayerHeight: CGFloat = 60

    private let audioTrackHeight: CGFloat = 10

    private let spacerHeight: CGFloat = 1

    private let fullAudioPlayerHeight: CGFloat

    @Environment(\.presentationMode) private var presentationMode

    init(viewModel: GalleryDetailsViewModel) {
        self.viewModel = viewModel
        self.imageLoader = AsyncImageLoader(url: viewModel.item.media)

        fullAudioPlayerHeight = audioTrackHeight + minPlayerHeight
    }

    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            let imageHeight = (frame.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom) * imageScreenHeightPercent

            let maxPlayerHeight = (frame.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom) * audioPlayerHeightPercent
            ZStack {
                GalleryDetailsImageView(imageURL: viewModel.item.media,
                                        opacity: $imageOpacity,
                                        imageHeight: .constant(imageHeight))
                .frame(maxWidth: frame.size.width + proxy.safeAreaInsets.leading + proxy.safeAreaInsets.trailing)

                VStack(spacing: 0) {
                    GalleryDetailsContentView(viewModel: viewModel,
                                              contentTopPadding: imageHeight + galleryDetailsContentTopPadding) { scrollRect in
                        changeImageOpacity(for: scrollRect, in: proxy)
                    }

                    Spacer()
                        .frame(height: isPlayerPresented ? bottomBarHeight + fullAudioPlayerHeight : bottomBarHeight)
                }

                VStack(spacing: 0) {
                    AudioPlayerView(details: viewModel.audioDetails,
                                    maxPlayerHeight: maxPlayerHeight,
                                    minPlayerHeight: minPlayerHeight,
                                    audioTrackHeight: audioTrackHeight,
                                    separatorHeight: spacerHeight,
                                    backgroundColor: .gray,
                                    isExpanded: $isExpanded)
                    .padding(EdgeInsets(top: 0,
                                        leading: proxy.safeAreaInsets.leading,
                                        bottom: 0,
                                        trailing: proxy.safeAreaInsets.trailing))
                    
                    Spacer()
                        .frame(height: isPlayerPresented ? bottomBarHeight : bottomBarHeight - fullAudioPlayerHeight)
                }

                VStack(spacing: 0) {
                    Spacer()
                    GalleryDetailsBottomBar(spacerHeight: spacerHeight) {
                        presentationMode.wrappedValue.dismiss()
                    } audioTapAction: {
                        withAnimation {
                            if isPlayerPresented {
                                isExpanded = false
                            }
                            isPlayerPresented.toggle()
                        }
                    }
                    .frame(height: bottomBarHeight)
                    .background(.white)
                    .padding(EdgeInsets(top: 0,
                                        leading: proxy.safeAreaInsets.leading,
                                        bottom: 0,
                                        trailing: proxy.safeAreaInsets.trailing))
                }
            }
            .ignoresSafeArea(edges: .all)
        }
    }

    func changeImageOpacity(for scrollRect: CGRect, in proxy: GeometryProxy) {
        var value: CGFloat = 0
        if scrollRect.minY < 0 {
            let height = proxy.size.height * imageScreenHeightPercent - proxy.safeAreaInsets.top
            let percent = (-scrollRect.minY * maxImageOpacity) / height
            value = percent < maxImageOpacity ? percent : maxImageOpacity
        }
        imageOpacity = value
    }
}

#Preview {
    let item = GalleryDetailsItem(title: "Piece of Art",
                                  link: URL(string:"https://www.flickr.com/photos/199921799@N02/54341118456/")!,
                                  media: URL(string: "https://live.staticflickr.com/65535/54341118456_e79226d825_m.jpg")!,
                                  dateTaken: Date(),
                                  published: Date(),
                                  author: "nobody",
                                  authorId: "199921799@N02",
                                  tags: "louvre paris art museum sculture statue")
    let viewModel = GalleryDetailsViewModel(item: item)
    GalleryDetailsView(viewModel: viewModel)
}
