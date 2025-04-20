////
////  ScanView.swift
////  pdfApp
////
////  Created by Ashish on 04/04/25.
////
//
//import SwiftUI
//import UniformTypeIdentifiers
//struct ScanView: View {
//    var images:[imageHasher]
//    var columns=Array(repeating: GridItem(.flexible()), count: 2)
//    @State var draggingItem:Image?
//    var body: some View {
//        ScrollView{
//        LazyVGrid(columns:columns)
//        {
//            ForEach(0..<images.count)
//            {
//              
//                i in
//                GeometryReader{
//                    let size=$0.size
//                        let image=images[i]
//                    ThumbViewScan(image:image.swiftUIImage)
//                  .overlay{
//                    Rectangle().stroke(.gray,lineWidth:1)
//                  }.draggable(image)
//                    {
//                        ThumbViewScan(image:image.swiftUIImage)
//                    }.dropDestination(for:imageHasher.self)
//                    {
//                        droppedTask,location in
//                        print(droppedTask.first.id)
//                        return true
//                    }
//                }
//            }
//        }.frame(width:UIScreen.main.bounds.width-10)
//    }
//    }
//    
//}
//enum ConversionError: Error {
//    case failedToConvertToPNG
//}
//
//extension imageHasher: Transferable {
//    public static var transferRepresentation: some TransferRepresentation {
//        DataRepresentation(contentType: .png) { imageHasher in
//            guard let data = imageHasher.image.pngData() else {
//                throw ConversionError.failedToConvertToPNG
//            }
//            return data
//        } importing: { data in
//            guard let uiImage = UIImage(data: data) else {
//                throw ConversionError.failedToConvertToPNG
//            }
//            return imageHasher(image: uiImage)
//        }
//    }
//    var swiftUIImage:Image{
//        Image(uiImage:image)
//    }
//}
//struct ThumbViewScan:View {
//    var id=UUID()
//    var image:Image
//    var body: some View {
//        
//            ZStack{
//                image.resizable().scaledToFit()
//            }.frame(width:100,height:150)
//        
//    }
//}
//
//struct scanHasher:Hashable,Identifiable
//{
//    var id:UUID
//    var images:[imageHasher]
//    
//    init(images: [imageHasher]) {
//        self.id = UUID()
//        self.images = images
//    }
//    func  hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//struct imageHasher:Hashable,Identifiable{
//    
//    var id:UUID
//    var image:UIImage
//    
//    init(image: UIImage) {
//        self.id = UUID()
//        self.image = image
//    }
//    
////    static var transferRepresentation: some TransferRepresentation
////    {
////        FileRepresentation(exportedContentType: .imageDoc)
////        {
////            imageDoc in
////        
////        }
////    }
//}
////extension UIImage: Transferable {
////    public static var transferRepresentation: some TransferRepresentation {
////        DataRepresentation(exportedContentType: .png) { image in
////            if let pngData = image.pngData() {
////                return pngData
////            } else {
////                throw ConversionError.failedToConvertToPNG
////            }
////        }
////    }
////}
////enum ConversionError: Error {
////    case failedToConvertToPNG
////}
////extension imageHasher {
////    var swiftUIImage: Image {
////        Image(uiImage: image)
////    }
////}
////extension UTType {
////    static var taxForm = UTType(exportedAs: ".jpeg")
////    static var imageDoc = UTType(exportedAs: ".jpeg")
////}
//////#Preview {
////    ScanView()
////}

//
//  ScanView.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import SwiftUI
import UniformTypeIdentifiers
import PDFKit
struct ScanView: View {
    var images: [imageHasher]
    @Binding var navPath:NavigationPath
    var columns = Array(repeating: GridItem(.flexible()), count: 3)
   @State var isLoadin:Bool=false
    var body: some View {
        ZStack{
            if isLoadin{
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
            }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<images.count, id: \.self) { i in
                    let image = images[i]
                    
                    GeometryReader { geometry in
                        let thumb = VStack(spacing:5){ThumbViewScan(image: image.swiftUIImage)
                                .overlay(
                                    Rectangle().stroke(.gray, lineWidth: 1)
                                )
                            HStack{
                                Spacer()
                                Text("\(i+1)")
                                Spacer()
                            }
                        }
                        
                        thumb
                            .draggable(image) {
                                ThumbViewScan(image: image.swiftUIImage)
                            }
                            .dropDestination(for: imageHasher.self) { droppedItems, location in
                                if let first = droppedItems.first {
                                    print(first.id)
                                }
                                return true
                            }
                    }
                    .frame(height: 160) // fixes unpredictable geometry height
                }
            }
            .padding().toolbar(id:"scanner"){
                ToolbarItem(id: "filename", placement: .primaryAction) {
                    Button{
                        DispatchQueue.global(qos: .userInitiated).async
                        {
                            DispatchQueue.main.async{
                                isLoadin=true
                            }
                            let pdf=makePDF()
                            let pdfview=PDFKitView(pdfDocument: pdf,getWaterMark: false)
                            var attrs=pdf.documentAttributes
                            attrs![PDFDocumentAttribute.titleAttribute]="Merged.pdf"
                            DispatchQueue.main.asyncAfter(deadline: .now()+2)
                            {
                                navPath.append(PDFHashed(pdfDoc: pdf))
                            }
                            
                            
                        }
                    }label:{
                        Text("Export PDFs")
                    }
                    
                }
            }
        }
    }
    }
    
    func makePDF()->PDFDocument
    {
        let pdfDocument=PDFDocument()
        
        for i in 0..<images.count{
            let page=PDFPage(image:images[i].image)
                             pdfDocument.insert(page!, at: i)
        }
                             return pdfDocument
    }
}

struct ThumbViewScan: View {
    var id = UUID()
    var image: Image

    var body: some View {
        ZStack {
            image
                .resizable()
                .scaledToFit()
        }
        .frame(width: 100, height: 150)
    }
}

// MARK: - Model Structures

struct imageHasher: Hashable, Identifiable {
    var id: UUID
    var image: UIImage

    init(image: UIImage) {
        self.id = UUID()
        self.image = image
    }

    var swiftUIImage: Image {
        Image(uiImage: image)
    }
}

struct scanHasher: Hashable, Identifiable {
    var id: UUID
    var images: [imageHasher]

    init(images: [imageHasher]) {
        self.id = UUID()
        self.images = images
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Transferable Support

enum ConversionError: Error {
    case failedToConvertToPNG
}

extension imageHasher: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .png) { imageHasher in
            guard let data = imageHasher.image.pngData() else {
                throw ConversionError.failedToConvertToPNG
            }
            return data
        } importing: { data in
            guard let uiImage = UIImage(data: data) else {
                throw ConversionError.failedToConvertToPNG
            }
            return imageHasher(image: uiImage)
        }
    }
}
