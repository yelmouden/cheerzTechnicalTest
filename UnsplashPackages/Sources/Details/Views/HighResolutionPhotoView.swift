//
//  SwiftUIView.swift
//
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import DesignSystem
import SwiftUI
import Utils

struct HighResolutionPhotoView: View {
    let viewModel: HighResolutionPhotoViewModel

    var body: some View {
        MainContainer {
            Text(.localizable.highResolutionViewTitle)
                .font(.headline)
                .bold()
                .foregroundStyle(DSColors.whiteText.swiftUIColor)
                .padding()

            Spacer()
           
            UnsplashWebImage(path: viewModel.urlPhoto) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                VStack {
                    Spacer()
                    LoaderView()
                        .frame(width: 30, height: 30)
                    Spacer()

                }

            }

            Spacer()
        }
    }
}

/*
 #Preview {
 HighResolutionPhotoView()
 }*/
