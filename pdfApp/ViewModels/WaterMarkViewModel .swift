//
//  WaterMarkViewModel .swift
//  pdfApp
//
//  Created by Ashish on 08/04/25.
//

import Foundation

import PDFKit

class WaterMarkViewModel:ObservableObject
{
    @Published var pdfArr:[PDFModel]=[]
    @Published var PDFThumbnails:[PDFKitThumbnailView]=[]
    @Published var WaterMarkString:NSMutableAttributedString=NSMutableAttributedString()
    func makePDFThumbnail(pdfDoc:PDFDocument)
    {
        let thumb=PDFKitThumbnailView(pdfDoc: pdfDoc)
            PDFThumbnails.append(thumb)
    }
}
