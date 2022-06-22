//
//  ComicView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import SwiftUI

/// View to show the Comic.
struct ComicView: View {
    /// Title of the comic.
    let title: String
    
    /// A description.
    let desc: String?
    
    /// A variant description of the comic.
    let variantDesc: String?
    
    /// The comic image.
    let image: Image?
    
    var body: some View {
        GroupBox {
            VStack(spacing: 10) {
                if let image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 300, maxHeight: 400)
                        .accessibilityLabel("comic-image")
                }
                
                Text(title)
                    .font(.title)
                    .bold()
                
                if let desc {
                    Text(desc)
                } else if let variantDesc {
                    Text(variantDesc)
                }
            }
            .frame(maxHeight: 500)
            .padding()
        }
        .padding()
    }
}

/// SwiftUI preview for the ``ComicView``.
struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView(title: "Marvel Previews (2017)",
                  desc: "Size does matter.  And no one knows this more than Hank Pym - a.k.a. Ant-Man. Got a problem with Galactus? Call the FF. Got a problem with, say, mind-controlled cockroaches? Then Ant-Man's your man! And needless to say, it's done a number on our diminutive hero's self-esteem.  When Ant-Man is tapped to infiltrate an international spy ring that has been siphoning secrets out of Washington, he jumps at the chance - unaware that he's being used as a pawn in a larger game of espionage.\r\n32 PGS./PARENTAL ADVISORY...$2.99",
                  variantDesc: nil,
                  image: Image("marvel-image"))
            .previewLayout(.fixed(width: 500, height: 800))
    }
}
