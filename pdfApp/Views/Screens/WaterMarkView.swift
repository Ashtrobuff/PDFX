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
    @State var recentSelector:Bool=false
    @EnvironmentObject var waterMarkVm:WaterMarkViewModel
    @Binding var navPath:NavigationPath
    enum NavigationDestinations: String, CaseIterable, Hashable {
     
        case WaterMark
    }
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
                    .listRowSeparator(.hidden).listRowInsets(.init(top: 1, leading: 1, bottom: 10, trailing: 1))
            }  .listRowSeparator(.hidden)
//            VStack{
//                Text("Preview").foregroundStyle(.secondary).foregroundColor(.secondary)
//                PDFWaterView(pdfDocument: waterMarkVm.pdfArr.first?.pdfDoc, getWaterMark:true).frame(width:UIScreen.main.bounds.width-20,height:400)
//            }
        }
//        Button
//        {
//            WaterMarkSheetShown.toggle()
//        }label:{
//            Label{
//                Text("Edit WaterMark")
//            }icon:{
//                Image(systemName: "pencil")
//            }
//        }.sheet(isPresented: $WaterMarkSheetShown)
//        {    WaterMarkPage()
//        }.buttonStyle(.bordered)
//            .controlSize(.small).padding().tint(.blue.opacity(0.5))
        VStack{
            HStack{
                Button{
                    recentSelector.toggle()
                }label:{
                    Label{
                        Text("Recents")
                    }icon: {
                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    }.frame(maxWidth: .infinity)
                }
                .controlSize(.large).tint(.blue).buttonStyle(.bordered).sheet(isPresented: $recentSelector)
                {
                    RecentPicker(navPath: $navPath,pdfArr: $waterMarkVm.pdfArr).presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }

            Button
            {
                
            
                importerShown.toggle()
            }label:
            {
                
                Label{
                    Text("Files")
                }icon:{
                    Image(systemName:"folder")
                }.frame(maxWidth: .infinity)
               
            }
                    .controlSize(.large).tint(.blue).buttonStyle(.bordered)
            }.fixedSize(horizontal: false, vertical: true).padding()
            Button
            {
                
                navPath.append(NavigationDestinationsEnum.WaterMark)
  
            }label:
            {
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(maxHeight:55)
                    Text("Proceed").foregroundColor(.white)
                }.padding()
                
            }.disabled(waterMarkVm.pdfArr.isEmpty)
            
    }.fileImporter(isPresented: $importerShown, allowedContentTypes: [.pdf],allowsMultipleSelection:
                    true)
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

//
//#Preview {
//    WaterMarkView()
//}
