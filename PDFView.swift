//
//  PDFView.swift
//  pdfApp
//
//  Created by Ashish on 02/04/25.
//

import SwiftUI
import PDFKit
struct PDFKitView: UIViewRepresentable,Hashable{
    @EnvironmentObject var water:WaterMarkViewModel
    var id=UUID()
    typealias UIViewType = PDFView
    
    var pdfDocument:PDFDocument?
    var getWaterMark:Bool=false
    init(pdfDocument: PDFDocument?,getWaterMark:Bool) {
       
        self.pdfDocument = pdfDocument
        self.getWaterMark = getWaterMark
      
        
    }
    func makeUIView(context: Context) -> PDFView {
        
        let pdfView=PDFView()
        
        pdfView.autoScales=true
        WaterMarkPageClass.WaterString=water.WaterMarkString
        DispatchQueue.main.async{
        let data=pdfDocument?.dataRepresentation()
        if let newData=data{
            let  newDoc=PDFDocument(data: newData)
            newDoc!.delegate=context.coordinator
            pdfView.document=newDoc
            //pdfDocument?.delegate=context.coordinator
        }
    }
        
//        if let doc = self.pdfDocument {
//            
//            pdfView.document = doc
// 
//                  print("✅ PDF successfully loaded into PDFView")
//              } else {
//                  print("❌ Error: PDFDocument is nil")
//              }

    
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
 
 
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator:NSObject,PDFDocumentDelegate
    {
     
            
        var parent:PDFKitView
            
        init( _ parent: PDFKitView) {
                self.parent = parent
            }
        func classForPage() -> AnyClass {
            if parent.getWaterMark==true
            {  return WaterMarkPageClass.self}
            else{
                return CleanPDFPageClass.self
            }
        }
        
    }
    static func == (lhs: PDFKitView, rhs: PDFKitView) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
private class PikachuWatermark: PDFPage {
    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        super.draw(with: box, to: context)
        
        UIGraphicsPushContext(context)
        context.saveGState()

        // translate and scale for different coordinate system
        // (0, 0) at top left corner
        let pageBounds = self.bounds(for: box)
        context.translateBy(x: 0, y: pageBounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        
        if let heart = UIImage(systemName: "heart.fill") {
            heart.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        }
        
        context.rotate(by: CGFloat.pi/6.0)

        let string: NSString = "Pikachu! 2025/01/01"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64)
        ]

        string.draw(at: CGPoint(x: 250, y: 100), withAttributes: attributes)

        context.restoreGState()
        UIGraphicsPopContext()
    }
}

