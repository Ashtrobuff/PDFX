//
//  File.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import Foundation
import PDFKit
import SwiftUI
class MergeViewModel:ObservableObject
{
    @Published var pdfArr:[PDFModel]=[]
    @Published var PDFThumbnails:[PDFKitThumbnailView]=[]
    
    static   func makePDFThumbnail(pdfDoc:PDFDocument)->Image
    {
        var image_:Image
              if let pdfPage = pdfDoc.page(at: 0) {
                  let pdfPageSize = pdfPage.bounds(for: .mediaBox)
                  let renderer = UIGraphicsImageRenderer(size: pdfPageSize.size)
                  
                  let image = renderer.image { ctx in
                      UIColor.white.set()
                      ctx.fill(pdfPageSize)
                      ctx.cgContext.translateBy(x: 0.0, y: pdfPageSize.size.height)
                      ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                      
                      pdfPage.draw(with: .mediaBox, to: ctx.cgContext)
                  }
                   image_=Image(uiImage: image)
               
                  return image_
              }
        
        
        return Image(systemName: "text.document")
    }
    func mergePDFs()->PDFDocument?
    {
        let newPDFDoc=PDFDocument()
      
        
        
        for i in self.pdfArr
        {
            for p in 0..<i.pdfDoc.pageCount
            {
                let page=i.pdfDoc.page(at: p)!
                let copiedPage=page.copy() as! PDFPage
                newPDFDoc.insert(copiedPage, at: newPDFDoc.pageCount)
            }
        }
        return newPDFDoc
    }

}

struct PDFModel:Identifiable{
    var id=UUID()
    var pdfDoc:PDFDocument
    var pdfThumbnail:Image
    var name:String
    var pages:Int
    init( pdfDoc: PDFDocument, pdfThumbnail: Image, name: String, pages: Int) {
        self.id = UUID()
        self.pdfDoc = pdfDoc
        self.pdfThumbnail = pdfThumbnail
        self.name = name
        self.pages = pages
    }
    static func == (lhs: PDFModel, rhs: PDFModel) -> Bool {
            return
        lhs.id==rhs.id &&
        lhs.pdfDoc==rhs.pdfDoc
    }
}
