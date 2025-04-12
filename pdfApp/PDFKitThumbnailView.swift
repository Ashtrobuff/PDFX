//
//  PDFKitThumbnailView.swift
//  pdfApp
//
//  Created by Ashish on 05/04/25.
//

import Foundation
import SwiftUI
import PDFKit
import UIKit
struct PDFKitThumbnailView:UIViewRepresentable
{
    
    var pdfDoc:PDFDocument?
    init(pdfDoc:PDFDocument  ) {
        self.pdfDoc = pdfDoc
    }
    func makeUIView(context: Context) -> PDFThumbnailView {
        let pdfThumbNailView=PDFThumbnailView()
        if let doc=pdfDoc
        {
            print("PDF initiated for thumbnail")
            let PDFView=PDFView()
            PDFView.document=doc
            pdfThumbNailView.pdfView=PDFView
        }else{
            print("can't load PDFs for thumbnail")
        }
        return pdfThumbNailView
    }
    
    func updateUIView(_ uiView: PDFThumbnailView, context: Context) {
        
    }
    
    typealias UIViewType = PDFThumbnailView

}
