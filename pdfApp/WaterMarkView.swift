//
//  WaterMarkView.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import SwiftUI
import PDFKit
struct WaterMarkView: View {
    @State var WaterMarkSheetShown:Bool=false
    @State var importerShown:Bool=false
    @StateObject var waterMarkVm = WaterMarkViewModel()

    var body: some View {
        
        if(waterMarkVm.pdfArr.isEmpty)
        {VStack{
            Spacer()
            EmptyDocsView()
            Spacer()
        }
        }
        else {
            List($waterMarkVm.pdfArr)
            { item in
                let pc=item.pages
                let thumb=item.pdfThumbnail
                let name=item.name
                ThumbnailPDF(image:thumb, name:name, pC:pc).listRowBackground(Color.clear)
                    .listRowSeparator(.hidden).listRowInsets(.none)
            }
        }
        Button
            {
                WaterMarkSheetShown.toggle()
            }label:{
                Label{
                    Text("Edit WaterMark")
                }icon:{
                    Image(systemName: "pencil")
                }
            }.sheet(isPresented: $WaterMarkSheetShown)
        {    WaterMarkPage() 
            }.buttonStyle(.bordered)
            .controlSize(.small).padding().tint(.blue.opacity(0.5))
        
        Button
        {
            importerShown.toggle()
        }label:
        {
            if(waterMarkVm.pdfArr.isEmpty)
            {Text("Select Files")}
            else
            {
                Text("WaterMark PDFs")
            }
        }.buttonStyle(.borderedProminent)
            .controlSize(.large).foregroundColor(.white).padding().tint(.blue).fileImporter(isPresented: $importerShown, allowedContentTypes: [.pdf],allowsMultipleSelection: true)
        {
            result in
            if let fileurlArr = try? result.get() as? [URL]
            {
                for fileurl in fileurlArr{
                
                    if(fileurl.startAccessingSecurityScopedResource()){
                    DispatchQueue.global(qos:.userInitiated).async{
                        if let doc=makeFile(url: fileurl){
                            let PDFModel=PDFModel(pdfDoc: doc, pdfThumbnail: MergeViewModel.makePDFThumbnail(pdfDoc: doc), name: fileurl.lastPathComponent, pages: doc.pageCount)
                            DispatchQueue.main.async{
                                do{
                                    let PDFview=PDFKitView(pdfDocument: doc,getWaterMark: false
                                    )}
                                catch{
                                    print(error)
                                }
                                
                                waterMarkVm.pdfArr.append(PDFModel)
                                fileurl.stopAccessingSecurityScopedResource()
                            }
                        }
                    }
                }
              
            }
            }
            
        }
        }
    func makeFile(url:URL)->PDFDocument?{
      if  let pdfDoc=PDFDocument(url: url)
        {
          return pdfDoc
      }
        return nil
    }
    }


#Preview {
    WaterMarkView()
}
