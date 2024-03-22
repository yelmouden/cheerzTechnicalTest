//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import SwiftUI

public struct ErrorView: View {
    private let retry: () -> Void

    public init(retry: @escaping () -> Void) {
        self.retry = retry
    }

    public var body: some View {
        VStack {
            Text(.localizable.errorViewTitle)
                .font(.headline)
                .foregroundStyle(DSColors.whiteText.swiftUIColor)

            UnsplahButton(
                title: .localizable.errorButtonTitle,
                action: retry
            )
            .unsplashButtonStyle(.primary)
        }
        .padding()
    }
}

#Preview {
    ErrorView(retry: {})
        .background(DSColors.background.swiftUIColor)
}
