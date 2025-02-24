//
//  GalleryDetailsItem.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import Foundation

struct GalleryDetailsItem: Hashable, Identifiable {
    var id: String { link.absoluteString }
    let title: String
    let link: URL
    let media: URL
    let dateTaken: Date
    let published: Date
    let author: String
    let authorId: String
    let tags: String
}

extension GalleryDetailsItem {

    var horizontalGalleryCellItem: HorizontalGalleryCellItem {
        return HorizontalGalleryCellItem(title: title, imageUrl: media)
    }
}
