//
//  PhotoCell.swift
//
//
//  Created by Yassin El Mouden on 17/03/2024.
//

import Localizable
import SDWebImageSwiftUI
import SwiftUI
import Utils

public struct PhotoCell: View {
    let urlPhoto: String
    let userName: String
    let urlUserProfile: String
    let nbLikes: Int

    @State private var animatedNumber: Int = 0

    public init(
        urlPhoto: String,
        userName: String,
        urlUserProfile: String,
        nbLikes: Int
    ) {
        self.urlPhoto = urlPhoto
        self.userName = userName
        self.urlUserProfile = urlUserProfile
        self.nbLikes = nbLikes
    }

    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            UnsplashWebImage(path: urlPhoto) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .clipped()
            } placeholder: {
                Color.clear
            }
            VStack {
                Spacer()
                EncartView(
                    urlProfile: urlUserProfile,
                    userName: userName,
                    nbLikes: nbLikes
                )
            }

        }
        .frame(height: 230)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.small)
            .stroke(Color.gray, lineWidth: 1)
        )
        .background(Color.black)
        .cornerRadius(8)
        .padding([.leading, .trailing], CornerRadius.small)

    }
}

struct EncartView: View {
    let urlProfile: String
    let userName: String
    let nbLikes: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UnsplashWebImage(path: urlProfile) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Color.gray
                        .clipShape(Circle())
                }
                .frame(width: 32, height: 32)


                Text("\(userName)")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(DSColors.whiteText.swiftUIColor)

                Spacer()
            }
            .padding(Margins.small)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.6))
    }
}
#Preview {
    PhotoCell(
        urlPhoto: "",
        userName: "",
        urlUserProfile: "",
        nbLikes: 10
    )
}
