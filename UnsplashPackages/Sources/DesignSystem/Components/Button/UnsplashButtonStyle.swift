//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import Foundation
import SwiftUI

// MARK: - Configuration

public struct UnsplashButtonConfiguration {
    let title: LocalizedStringResource
    let action: (() -> Void)
}

public protocol UnsplashButtonStyle {
    associatedtype Body: View

    @ViewBuilder
    func makeBody(configuration: Configuration) -> Body

    typealias Configuration = UnsplashButtonConfiguration
}

struct UnsplashButtonStyleKey: EnvironmentKey {
    static var defaultValue: any UnsplashButtonStyle = UnsplashButtonDefaultStyle()
}

extension EnvironmentValues {
    var unsplashButtonStyle: any UnsplashButtonStyle {
        get { self[UnsplashButtonStyleKey.self] }
        set { self[UnsplashButtonStyleKey.self] = newValue }
    }
}

public extension View {
    func unsplashButtonStyle(_ style: some UnsplashButtonStyle) -> some View {
        environment(\.unsplashButtonStyle, style)
    }
}

public extension UnsplashButtonStyle where Self == UnsplashButtonPrimaryStyle {
    static var primary: Self { .init() }
}

// MARK: - Styles Defined in Design System

public struct UnsplashButtonDefaultStyle: UnsplashButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.action()
        } label: {
            Text(configuration.title)
                .foregroundStyle(DSColors.whiteText.swiftUIColor)
        }
    }
}

public struct UnsplashButtonPrimaryStyle: UnsplashButtonStyle {

    @State var animateOpacitySuccess = false

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {

        Button(action: {
            configuration.action()
        },
               label: {
            HStack {
                Spacer()
                Text(configuration.title)
                    .font(.body)
                    .foregroundStyle(DSColors.whiteText.swiftUIColor)
                Spacer()

            }
        })
        .frame(height: 44)
        .background(DSColors.backgroundButtonPrimary.swiftUIColor)
        .cornerRadius(40)
    }
}
