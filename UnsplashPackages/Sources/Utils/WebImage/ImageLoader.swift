//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

public protocol ImageLoaderType: Observable {
    func load(path: String, completion: @escaping ((UIImage?) -> Void))
    func cancel(for path: String)
}

public struct ImageLoaderServiceKey: EnvironmentKey {
    public static let defaultValue: any ImageLoaderType = ImageLoader()

}

public extension EnvironmentValues {
    var imageLoader: ImageLoaderType {
        get { self[ImageLoaderServiceKey.self] }
        set { self[ImageLoaderServiceKey.self] = newValue
        }
    }
}

@Observable
public class ImageLoader: ImageLoaderType {
    
    @ObservationIgnored
    private var operations: [String: SDWebImageCombinedOperation] = [:]

    public init() {}

    public func load(path: String, completion: @escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: path) else {
            completion(nil)
            return
        }

        let imageManager = SDWebImageManager()

        let operation = imageManager.loadImage(
            with: url,
            options: [],
            context: [:],
            progress: nil
        ) { image, _, _, _, _, _ in
            completion(image)
        }

        operations[url.absoluteString] = operation
    }

    public func cancel(for path: String) {
        operations[path]?.cancel()
    }
}

@Observable
public class ImageLoaderMock: ImageLoaderType, ObservableObject {
    var images: [String: UIImage]

    public init(images: [String: UIImage]) {
        self.images = images
    }

    public func load(path: String, completion: @escaping ((UIImage?) -> Void)) {
        completion(images[path])
    }

    public func cancel(for path: String) {}
}
