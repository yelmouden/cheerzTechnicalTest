//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import SwiftUI

public struct UnsplashWebImage<ContentView: View, Placeholder: View>: View {
    @State private var image: UIImage?
    @Environment(\.imageLoader) private var imageLoader

    private let path: String
    private var content: ((Image) -> ContentView)
    private var placeholder: (() -> Placeholder)

    public init(
        path: String,
        @ViewBuilder content: @escaping ((Image) -> ContentView),
        @ViewBuilder placeholder: @escaping (() -> Placeholder)
    ) {
        self.path = path
        self.content = content
        self.placeholder = placeholder
    }
    public var body: some View {
        VStack {
            if let image {
                content(Image(uiImage: image))
                   .transition(.fade)
            } else {
                placeholder()
            }
        }
        .onAppear {
            imageLoader.load(path: path) { image in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.image = image
                }
            }
        }
        .onDisappear {
            imageLoader.cancel(for: path)
        }

        .animate(.easeInOut, value: image)

    }
}

#Preview {
    UnsplashWebImage(path: "") { _ in
        EmptyView()
    } placeholder: {
        EmptyView()
    }
}
