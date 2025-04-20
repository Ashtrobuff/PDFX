//
//  MergeViewFinal.swift
//  pdfApp
//
//  Created by Ashish on 12/04/25.
//

import SwiftUI
import PDFKit
struct MergeViewFinal: View {
    var pdfDoc:PDFDocument
    @State var showShareSheet:Bool=false
    @State  var previewImage: Image = Image("")
    @State  var data: Data = Data()
    @State  var filename: String=""
    @State var fileTitle:String="filetitle.pdf"{
        didSet{
            setFileTitle()
        }
    }
    var body: some View {
        ZStack{
          
            PDFKitView(pdfDocument: pdfDoc, getWaterMark: false)
        }.toolbar(id:"finalmerge"){
            ToolbarItem(id: "settings", placement: .primaryAction) {
                
                ShareLink(item:pdfDoc,
                        preview: SharePreview(
                          filename,
                          image: previewImage
                        )
                      )

                   // Image(systemName:"square.and.arrow.up")
                
            }
            ToolbarItem(id: "filename", placement: .primaryAction) {
                TextField("Edit Filename", text:$fileTitle).onChange(of: fileTitle)
                {
                    setFileTitle()
                }
                
            }
            ToolbarItem(id: "markup", placement: .primaryAction) {
                Button{}label:{
                    Image(systemName:"pencil.tip.crop.circle")
                }
                
            }
        }.toolbarRole(.navigationStack).onAppear{
           guard let image = pdfDoc.imageRepresenation else {
               fatalError("something went wrong...")
             }
             pdfDoc.documentAttributes![PDFDocumentAttribute.titleAttribute] = filename
             self.previewImage = Image(uiImage: image)
        }.onAppear{
            setFileTitle()
        }
       
    }
    func setFileTitle()
    {
        PDFDocument.myTitleName=self.fileTitle
    }
}
extension PDFDocument {
    static var myTitleName:String?
  public var title: String? {
  guard let attributes = self.documentAttributes,
        let titleAttribute = attributes[PDFDocumentAttribute.titleAttribute]
  else { return nil }

  return titleAttribute as? String
  }
}
extension PDFDocument: Transferable {
public static var transferRepresentation: some TransferRepresentation {
  FileRepresentation(exportedContentType: .pdf) { pdf in
    guard let data = pdf.dataRepresentation() else {
    fatalError("Could not create a pdf file")
    }

      let fileManager = FileManager.default
      var fileURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

      let fu = fileURL.appendingPathComponent(myTitleName!)

    try data.write(to: fu)
    return SentTransferredFile(fu)
    }
  }
}

extension PDFDocument {
  public var imageRepresenation: UIImage? {
    guard let pdfPage = self.page(at: 0) else { return nil }
    let pageBounds = pdfPage.bounds(for: .cropBox)

    let renderer = UIGraphicsImageRenderer(size: pageBounds.size)
    let image = renderer.image { ctx in
      UIColor.white.set()
      ctx.fill(pageBounds)

      ctx.cgContext.translateBy(x: 0.0, y: pageBounds.size.height)
      ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(ctx.cgContext)
      pdfPage.draw(with: .cropBox, to: ctx.cgContext)
      UIGraphicsPopContext()
    }
    return image
  }
}
//#Preview {
//    MergeViewFinal()
//}
