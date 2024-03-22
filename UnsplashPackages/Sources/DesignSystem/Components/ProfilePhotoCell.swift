//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import SwiftUI
import Utils

public struct ProfilePhotoCell: View {
    let url: String

    public init(url: String) {
        self.url = url
    }

    public var body: some View {
        UnsplashWebImage(path: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        } placeholder: {
            Color.gray
                .clipShape(Circle())
        }
    }
}

#Preview {
    ProfilePhotoCell(url: "")
}
