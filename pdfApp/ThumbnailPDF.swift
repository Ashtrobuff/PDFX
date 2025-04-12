//
//  ThumbnailPDF.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI
import PDFKit

struct ThumbnailPDF: View {
    @Binding var image:Image
    @Binding  var name:String
    @Binding var pC:Int
     var body: some View {
        ZStack{
            HStack{
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width:70,height: 100)
                    .clipped()
                
//                Rectangle().frame(width:100,height:100)
               VStack{
                    
                    HStack{
                        Text("\(name)").fontWeight(.bold)
                        Spacer()
                }
                    HStack{
                        
                        Text("\(pC) pages") .foregroundColor(.secondary).font(.footnote)
                        Spacer()
                    }.padding(.trailing,10)
                }
               
                Spacer()
            }
        }.frame(height:100).background(Color.white)
            .cornerRadius(20).shadow(radius: 1).padding(10)
    }
}

#Preview {
    @Previewable @State var dummypdf=PDFModel(pdfDoc: PDFDocument(url: URL(string:"https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf")!)!, pdfThumbnail:Image("docimage"), name: "My Document.pdf", pages: 30)
    
    ThumbnailPDF(image: $dummypdf.pdfThumbnail, name: $dummypdf.name, pC: $dummypdf.pages)
}

