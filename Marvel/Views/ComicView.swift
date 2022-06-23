//
//  ComicView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import SwiftUI

/// View to show the Comic.
struct ComicView: View, Identifiable {
    /// The ID of the view.
    let id: UUID
    
    /// Title of the comic.
    let title: String
    
    /// A description.
    let desc: String?
    
    /// A variant description of the comic.
    let variantDesc: String?
    
    /// The comic image.
    var image: Image?
    
    /// Set the size to be a large view. Otherwise use the miniview.
    let largeSize: Bool
    
    init(id: UUID,
         title: String,
         desc: String?,
         variantDesc: String?,
         image: Image?,
         largeSize: Bool = true) {
        self.id = id
        self.title = title
        self.desc = desc
        self.variantDesc = variantDesc
        self.image = image
        self.largeSize = largeSize
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minHeight: (largeSize) ? 300 : 100,
                       maxHeight: (largeSize) ? 400 : 150)
                .accessibilityLabel("comic-image")
        }
    }
    
    @ViewBuilder
    private var description: some View {
        if largeSize {
            if let desc {
                Text(desc)
            } else if let variantDesc {
                Text(variantDesc)
            }
        }
    }
    
    var body: some View {
        GroupBox {
            VStack(spacing: 10) {
                imageView
                
                Text(title)
                    .font((largeSize) ? .title : .caption)
                    .bold()
                
                description
            }
            .frame(maxHeight: 500)
        }
    }
}

/// SwiftUI preview for the ``ComicView``.
struct ComicView_Previews: PreviewProvider {
    static func comicView(largeSize: Bool) -> some View {
        return ComicView(id: UUID(),
                         title: "Marvel Previews (2017)",
                         desc: "Size does matter.  And no one knows this more than Hank Pym - a.k.a. Ant-Man. Got a problem with Galactus? Call the FF. Got a problem with, say, mind-controlled cockroaches? Then Ant-Man's your man! And needless to say, it's done a number on our diminutive hero's self-esteem.  When Ant-Man is tapped to infiltrate an international spy ring that has been siphoning secrets out of Washington, he jumps at the chance - unaware that he's being used as a pawn in a larger game of espionage.\r\n32 PGS./PARENTAL ADVISORY...$2.99",
                         variantDesc: nil,
                         image: Image("marvel-image"),
                         largeSize: largeSize)
    }
    
    static var previews: some View {
        Group {
            comicView(largeSize: true)
                .previewLayout(.fixed(width: 500, height: 600))
                .previewDisplayName("Large View")
            
            comicView(largeSize: false)
                .previewLayout(.fixed(width: 300, height: 300))
                .previewDisplayName("Mini View")
        }
    }
}
