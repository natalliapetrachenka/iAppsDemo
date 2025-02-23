//
//  HorizontalGalleryDetailsView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import CoreApiClient
import SwiftUI

struct HorizontalGalleryDetailsView: View {
    @ObservedObject var viewModel: HorizontalGalleryDetailsViewModel

    var body: some View {
        Text(viewModel.item.title)
    }
}

#Preview {
    let item = HorizontalGalleryDetailsItem(title: "Piece of Art",
                                            link: URL(string:"https://www.flickr.com/photos/199921799@N02/54341118456/")!,
                                            media: URL(string: "https://live.staticflickr.com/65535/54341118456_e79226d825_m.jpg")!,
                                            dateTaken: Date(),
                                            published: Date(),
                                            author: "nobody",
                                            authorId: "199921799@N02",
                                            tags: "louvre paris art museum sculture statue")
    let viewModel = HorizontalGalleryDetailsViewModel(item: item)
    HorizontalGalleryDetailsView(viewModel: viewModel)
}
