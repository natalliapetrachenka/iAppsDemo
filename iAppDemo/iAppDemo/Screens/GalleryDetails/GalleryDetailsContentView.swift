//
//  GalleryDetailsContentView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 25.02.25.
//

import SwiftUI

struct GalleryDetailsContentView: View {
    @ObservedObject var viewModel: GalleryDetailsViewModel

    let contentTopPadding: CGFloat
    private let contentBottomPadding: CGFloat = 16
    private let contentHorizontalPadding: CGFloat = 10

    var onChangedScrollViewRect: ((CGRect) -> ())?

    private let scrollViewCoordinateSpaceName = "SCROLL"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(spacing: 12) {
                    Text(viewModel.item.title)
                        .font(.largeTitle)
                        .bold()

                    Link("Go to site", destination: viewModel.item.link)
                        .foregroundColor(.blue)

                    Text("Date: \(DateFormatter.defaultDateFormatter.string(from: viewModel.item.dateTaken))")

                    Text("Published: \(DateFormatter.defaultDateFormatter.string(from: viewModel.item.dateTaken))")

                    Text("Author: \(viewModel.item.author)")

                    Text("AuthorId: \(viewModel.item.authorId)")

                    Text("Tags: \(viewModel.item.tags)")

                }
                .padding(EdgeInsets(top: contentTopPadding,
                                    leading: contentHorizontalPadding,
                                    bottom: contentBottomPadding,
                                    trailing: contentHorizontalPadding))
                .offsetExtractor(coordinateSpace: scrollViewCoordinateSpaceName) { scrollRect in
                    onChangedScrollViewRect?(scrollRect)
                }
            }
            .coordinateSpace(name: scrollViewCoordinateSpaceName)
            .foregroundColor(.black)
        }
    }
}
