//
//  WaterViewFinal.swift
//  pdfApp
//
//  Created by Ashish on 13/04/25.
//

//
//  MergeViewFinal.swift
//  pdfApp
//
//  Created by Ashish on 12/04/25.
//

import SwiftUI
import PDFKit
struct WaterViewFinal: View {
    var pdfDoc:PDFDocument
    @State var showShareSheet:Bool=false
    @State  var previewImage: Image = Image("")
    @State  var data: Data = Data()
    @State var fileTitle:String="filetitle.pdf"{
        didSet{
            setFileTitle()
        }
    }
    @State  var filename: String=""
    var fileURL:URL?
    var body: some View {
        ZStack{
            PDFWaterView(pdfDocument: pdfDoc, getWaterMark: true)
        }.toolbar(id:"finalmerge"){
            ToolbarItem(id: "filename", placement: .primaryAction) {
                TextField("Edit Filename", text:$fileTitle).onChange(of: fileTitle)
                {
                    setFileTitle()
                }
                
            }
            ToolbarItem(id: "settings", placement: .primaryAction) {
                
                ShareLink(item: pdfDoc,
                        preview: SharePreview(
                          filename,
                          image: previewImage
                        )
                      )

                   // Image(systemName:"square.and.arrow.up")
                
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
        }
       
    }
    func setFileTitle()
    {
        PDFDocument.myTitleName=self.fileTitle
    }
}


//#Preview {
//    MergeViewFinal()
//}
