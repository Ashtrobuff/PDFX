//
//  MergeView.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import SwiftUI
import PDFKit
struct MergeView: View {
    @StateObject var mergevm = MergeViewModel()
    @State private var showImporter:Bool=false
    @Binding var navpath:NavigationPath
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
                        .listRowSeparator(.hidden).listRowInsets(.none)
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
                            let pdf=mergevm.mergePDFs()
                            let pdfview=PDFKitView(pdfDocument: pdf,getWaterMark: false)
                            pdfview.toolbar(id: "options") {
                                // this is a primary action, so will always be visible
                                ToolbarItem(id: "settings", placement: .primaryAction) {
                                    Button("Settings") { }
                                }

                                // this is a standard secondary action, so will be customizable
                                ToolbarItem(id: "help", placement: .secondaryAction) {
                                    Button("Help") { }
                                }

                                // another customizable button
                                ToolbarItem(id: "email", placement: .secondaryAction) {
                                    Button("Email Me") { }
                                }

                                // a third customizable button, but this one won't be in the toolbar by default
                                ToolbarItem(id: "credits", placement: .secondaryAction, showsByDefault: false) {
                                    Button("Credits") { }
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now()+2)
                            {
                                navpath.append(pdfview)
                            }
                            
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
                                    let PDFModel=PDFModel(pdfDoc: doc, pdfThumbnail: MergeViewModel.makePDFThumbnail(pdfDoc: doc), name: fileurl.lastPathComponent, pages: doc.pageCount)
                                    do{
                                        _=PDFKitView(pdfDocument: doc,getWaterMark: true)}
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

//#Preview {
//
//    MergeView()
//}
