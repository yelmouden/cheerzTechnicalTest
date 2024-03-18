//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import SwiftUI

public struct UnsplahButton: View {

    @Environment(\.unsplashButtonStyle)
    var style

    private let title: LocalizedStringResource
    private let action: (() -> Void)

    public init(
        title: LocalizedStringResource,
        action: @escaping (() -> Void)
    ) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        let configuration = UnsplashButtonConfiguration(
            title: title,
            action: action
        )

        AnyView(style.makeBody(configuration: configuration))
    }
}

#Preview {
    UnsplahButton(title: "title") {
        
    }
}
