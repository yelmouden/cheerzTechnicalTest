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
            ZStack {
                placeholder()

                if let image {
                    content(Image(uiImage: image))
                        .transition(.fade)
                }
            }
            .animate(.easeInOut, value: image)
        }
        .onAppear {
            imageLoader.load(path: path) { image in
                self.image = image
            }
        }
        .onDisappear {
            imageLoader.cancel(for: path)
        }
    }
}

#Preview {
    UnsplashWebImage(path: "") { _ in
        EmptyView()
    } placeholder: {
        EmptyView()
    }
}
