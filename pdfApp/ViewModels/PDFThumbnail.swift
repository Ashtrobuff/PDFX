//
//  PDFThumbnail.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import SwiftUI

struct PDFThumbnail: View {
    var body: some View {
        VStack{
            Rectangle().cornerRadius(10)
            VStack{
                Text("Ddsdf.pdf")
                HStack{
                    Spacer()
                    Text("9 pages").multilineTextAlignment(.trailing).foregroundColor(.secondary)
            }
            }
        }.cornerRadius(10).padding(10).frame(width:130,height:200).shadow(radius:1).overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 0.4)
        )
    }
}

#Preview {
    PDFThumbnail()
}
