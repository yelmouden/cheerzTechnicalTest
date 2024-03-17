//
//  MainContainer.swift
//
//
//  Created by Yassin El Mouden on 17/03/2024.
//

import Foundation
import SwiftUI

public struct MainContainer<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            DSColors.background.swiftUIColor
            VStack {
                content
            }
        }
        .background(DSColors.background.swiftUIColor)
    }
}
