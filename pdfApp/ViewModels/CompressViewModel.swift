//
//  CompressViewModel.swift
//  pdfApp
//
//  Created by Ashish on 10/04/25.
//

import Foundation
import PDFKit
import SwiftUI
class CompressViewModel:ObservableObject
{
    

    @Published var pdfArr:[PDFModel]=[]
    @Published var PDFThumbnails:[PDFKitThumbnailView]=[]
    
    func makePDFThumbnail(pdfDoc:PDFDocument)->Image
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
    func compressPDF(pdfDocument:PDFDocument){
 
        let newPDF=PDFDocument()
        var images: [UIImage] = []
        
        for pageNum in 0..<pdfDocument.pageCount {
            if let pdfPage = pdfDocument.page(at: pageNum) {
                let pdfPageSize = pdfPage.bounds(for: .mediaBox)
                let renderer = UIGraphicsImageRenderer(size: pdfPageSize.size)
                
                let image = renderer.image { ctx in
                    UIColor.white.set()
                    ctx.fill(pdfPageSize)
                    ctx.cgContext.translateBy(x: 0.0, y: pdfPageSize.size.height)
                    ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                    
                    pdfPage.draw(with: .mediaBox, to: ctx.cgContext)
                }
                
                images.append(image)
            }
        }
        
        for i in 0..<images.count{
           
           let compData=images[i].jpegData(compressionQuality:0.0)
            let imagecomp=UIImage(data: compData!)
            let pdfPage=PDFPage(image:imagecomp!)
            newPDF.insert(pdfPage!, at: i)
        }
        
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fname=pdfDocument.documentURL?.lastPathComponent
        let fileURL = documentsURL.appendingPathComponent(fname!)
        newPDF.write(to: fileURL)
        print("successfully created the doc")
    }
    

}

