//
//  PDFThumbSquare.swift
//  pdfApp
//
//  Created by Ashish on 12/04/25.
//

import SwiftUI
import PDFKit

struct PDFThumbSquare: View {
    var model:PDFModel?
    var Datecreated:String
    var body: some View {
        ZStack{
           
        VStack{
            model!.pdfThumbnail.resizable().scaledToFit().clipped()
            VStack(alignment:.leading){
                Text("\(model!.name)").font(.system(size: 15)).fontWeight(.medium)
                HStack{
                    
                    VStack(alignment:.leading){
                        Text("\(model!.pages) pages").font(.system(size: 13)).foregroundColor(.secondary)
                        Text("\(Datecreated)").font(.system(size: 9)).foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }.padding(.horizontal,8)
            HStack{
                Spacer()
                Button{
                    
                }label:{
                    Image(systemName:"ellipsis").rotationEffect(.degrees(90)).foregroundStyle(.secondary).foregroundColor(.gray)
                }
            }
        }.frame(width:100,height:150).padding(.bottom,10).padding(.top,5)
        }.padding(2).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 0.2)
        )    }
}

#Preview {
    var model=PDFModel(pdfDoc: PDFDocument(url: URL(string: "https://gactvd.in/Documents/Learning/Viscom/Basic%20Photography%20-PDF%201.pdf")!)!, pdfThumbnail: MergeViewModel
        .makePDFThumbnail(pdfDoc: PDFDocument(url: URL(string:"https://gactvd.in/Documents/Learning/Viscom/Basic%20Photography%20-PDF%201.pdf")!)!), name: "my dicc.pdf", pages: 60)
    PDFThumbSquare(model: model, Datecreated: "25/10/2202")
}
