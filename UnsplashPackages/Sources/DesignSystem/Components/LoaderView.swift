//
//  SwiftUIView.swift
//
//
//  Created by Yassin El Mouden on 19/02/2024.
//

import SwiftUI

public struct LoaderView: View {
    enum Constant {
        static let duration = 0.3
        static let extraBounce = 0.25

    }

    @State private var animateFirst: Bool = false
    @State private var animateSecond: Bool = false
    @State private var animateThird: Bool = false

    let color: Color

    public init(color: Color = DSColors.whiteText.swiftUIColor) {
        self.color = color
    }

    public var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
                .offset(x: 0, y: animateFirst ? -20 : 0)
                .animation(
                    .bouncy(
                        duration: Constant.duration,
                        extraBounce: Constant.extraBounce
                    ).repeatForever(autoreverses: true),
                    value: animateFirst
                )
            Circle()
                .fill(color)
                .offset(x: 0, y: animateSecond ? -20 : 0)
                .frame(width: 10, height: 10)
                .animation(
                    .bouncy(
                        duration: Constant.duration,
                        extraBounce: Constant.extraBounce
                    ).repeatForever(autoreverses: true),
                    value: animateSecond
                )
            Circle()
                .fill(color)
                .offset(x: 0, y: animateThird ? -20 : 0)
                .frame(width: 10, height: 10)
                .animation(
                    .bouncy(
                        duration: Constant.duration,
                        extraBounce: Constant.extraBounce
                    ).repeatForever(autoreverses: true),
                    value: animateThird
                )
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateFirst = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                animateSecond = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                animateThird = true
            }
        }

    }
}

#Preview {
    LoaderView(color: DSColors.whiteText.swiftUIColor)
        .frame(width: 100, height: 100)
        .background(Color.black)
}
