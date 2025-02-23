//
//  ImageCache.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI

class ImageCache {
    private var iconsImageCache: NSCache<AnyObject, UIImage>
    private let queue = DispatchQueue(label: "dispatch.queue.cache.images", attributes: .concurrent)

    static let shared = ImageCache()

    init() {
        let cache = NSCache<AnyObject, UIImage>()
        cache.countLimit = 1000
        cache.totalCostLimit = 10 * 1024 * 1024
        self.iconsImageCache = cache
    }
}

extension ImageCache {

    func getImage(for key: String) -> UIImage? {
        var imageFromCache: UIImage?
        queue.sync { [weak self] in
            guard let self = self else { return }
            imageFromCache = self.iconsImageCache.object(forKey: key as AnyObject)
        }
        return imageFromCache
    }

    func setUIImage(_ image: UIImage, for key: String) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.iconsImageCache.setObject(image, forKey: key as AnyObject)
        }
    }
}

extension ImageCache {

    func getImage(for url: URL, compressedImageSize: CGSize? = nil) -> Image? {
        if let image = getUIImage(for: url, compressedImageSize: compressedImageSize) {
            return Image(uiImage: image)
        }
        return nil
    }

    func getUIImage(for url: URL, compressedImageSize: CGSize? = nil) -> UIImage? {
        if let compressedImageSize = compressedImageSize {
            let genereatedKey = "\(url.absoluteString)-\(compressedImageSize.width)x\(compressedImageSize.height)"
            if let image = getImage(for: genereatedKey) {
                return image
            }
        }
        return getImage(for: url.absoluteString)
    }

    func setUIImage(_ image: UIImage, for url: URL, compressedImageSize: CGSize? = nil) {
        var key = url.absoluteString
        if let compressedImageSize = compressedImageSize {
            key += "-\(compressedImageSize.width)x\(compressedImageSize.height)"
        }
        setUIImage(image, for: key)
    }

}
