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
    @State private var recentSelector:Bool=false
    @Binding var navpath:NavigationPath
    var body: some View {
        ZStack{
            if($mergevm.pdfArr.isEmpty)
            {
                VStack(spacing:30)
                {
                    Image(systemName: "light.beacon.min").font(.system(size: 60)).fontWeight(.ultraLight)
                    Text("Select PDFs to Merge")
                }            }
            else
            {   VStack{
                List($mergevm.pdfArr,editActions: [.move,.delete])
                {
                    
                    item in
                    let pc=item.pages
                    let thumb=item.pdfThumbnail
                    let name=item.name
                    ThumbnailPDF(image:thumb, name:name, pC:pc).listRowBackground(Color.clear)
                        .listRowSeparator(.hidden).listRowInsets(.init(top: 1, leading: 1, bottom: 10, trailing: 1))
                    
                    
                }.backgroundStyle(.primary).background(.white).frame(height:560)
                Spacer()
            }
            }
            VStack(spacing:0.1){
                Spacer()
                HStack{
                Button{
                    recentSelector.toggle()
                }label:{
                    Label{
                        Text("Recents")
                    }icon: {
                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    }.frame(maxWidth:.infinity)
                }.controlSize(.large).tint(.blue).buttonStyle(.bordered).sheet(isPresented: $recentSelector)
                {
                    RecentPicker(navPath: $navpath,pdfArr: $mergevm.pdfArr).presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
                    Button{
                        
                        showImporter.toggle()
                    }label:{
                        Label{
                            Text("Files")
                        }icon:{
                            Image(systemName:"folder")
                        }.frame(maxWidth:.infinity)
                    }.controlSize(.large).tint(.blue).buttonStyle(.bordered)
                
                }.padding(.horizontal).fixedSize(horizontal: false, vertical: true)
                
                Button{
                        DispatchQueue.global(qos: .userInitiated).async
                        {
                            let pdf=mergevm.mergePDFs()
                            let pdfview=PDFKitView(pdfDocument: pdf,getWaterMark: false)
                            var attrs=pdf?.documentAttributes
                            attrs![PDFDocumentAttribute.titleAttribute]="tempster.pdf"
                            DispatchQueue.main.asyncAfter(deadline: .now()+2)
                            {
                                navpath.append(PDFHashed(pdfDoc: pdf!))
                            }
                            
                        }
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).frame(maxHeight:55)
                        Text("Merge PDFs").foregroundColor(.white)
                    }.padding()
                } .disabled(mergevm.pdfArr.isEmpty)
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

struct PDFWaterHasher:Hashable,Equatable{
    var id:UUID=UUID()
    var pdfDoc:PDFDocument
    init( pdfDoc: PDFDocument) {
        self.id = UUID()
        self.pdfDoc = pdfDoc
    }
}

#Preview {
    @State var navPath:NavigationPath=NavigationPath()
    MergeView(navpath: $navPath)
}
