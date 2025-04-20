//
//  CompressView.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import SwiftUI
import PDFKit
struct CompressView: View {
    @StateObject var mergevm = CompressViewModel()
    @State private var showImporter:Bool=false
    var body: some View {
        ZStack{
            if($mergevm.pdfArr.isEmpty)
            {
                VStack(spacing:30)
                {
                    Image(systemName: "light.beacon.min").font(.system(size: 60)).fontWeight(.ultraLight)
                    Text("Select PDFs to Merge")
                }
            }
            else
            {
                List($mergevm.pdfArr,editActions:.move)
                {
                   item in
                    let pc=item.pages
                    let thumb=item.pdfThumbnail
                    let name=item.name
                    ThumbnailPDF(image:thumb, name:name, pC:pc).listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
            }
            }
            VStack{
Spacer()
                Button{
                    if(mergevm.pdfArr.isEmpty)
                    {showImporter.toggle()}
                    else
                    {
                        
                        DispatchQueue.global(qos: .userInitiated).async
                        {
                            
                            mergevm.compressPDF(pdfDocument:mergevm.pdfArr.first!.pdfDoc)
                        }
                    }
                    
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).frame(maxHeight:55)
                        Text(mergevm.pdfArr.isEmpty ? "Select PDFs":"Merge PDFs").foregroundColor(.white)
                    }.padding()
                }
            }.fileImporter(isPresented: $showImporter, allowedContentTypes: [.pdf],allowsMultipleSelection: true)
            {
                result in
                if let fileurlArr = try? result.get() as? [URL]
                {
                    for fileurl in fileurlArr{
                    
                        if(fileurl.startAccessingSecurityScopedResource()){
                        DispatchQueue.global(qos:.userInitiated).async{
                            if let doc=makeFile(url: fileurl){
                                
                                DispatchQueue.main.async{
                                    let PDFModel=PDFModel(pdfDoc: doc, pdfThumbnail: mergevm.makePDFThumbnail(pdfDoc: doc), name: fileurl.lastPathComponent, pages: doc.pageCount)
                                    do{
                                        let PDFview=PDFKitView(pdfDocument: doc,getWaterMark: false)}
                                    catch{
                                        print(error)
                                    }
                                    mergevm.pdfArr.append(PDFModel)
                                    fileurl.stopAccessingSecurityScopedResource()
                                }
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
    CompressView()
}
