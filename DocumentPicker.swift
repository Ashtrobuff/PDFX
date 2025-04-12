//
//  DocumentPicker.swift
//  pdfApp
//
//  Created by Ashish on 02/04/25.
//

import SwiftUI
import UIKit
import PDFKit
struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var filePath:URL?
    @Binding var showView:Bool
    @Binding var NavigationPath:NavigationPath
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
  
        var docPicker=UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        docPicker.delegate=context.coordinator
        return docPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }
    func appendToNavPath()
    {
        guard let filePath = filePath else {
            print("filePath is nil")
            return
        }
    
        if filePath.startAccessingSecurityScopedResource() {
            defer { filePath.stopAccessingSecurityScopedResource() }

            // Now, try loading the PDF
            if let doc = PDFDocument(url: filePath) {
                let pdfView = PDFKitView(pdfDocument: doc,getWaterMark: false)
                NavigationPath.append(pdfView)
            } else {
                print("❌ Failed to load PDF document.")
            }
        } else {
            print("❌ Could not access security-scoped resource.")
        }
   
    }
    
    typealias UIViewControllerType=UIDocumentPickerViewController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator:NSObject,UIDocumentPickerDelegate{
        
        var parent:DocumentPicker
        
        init( _ parent: DocumentPicker) {
            self.parent = parent
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            self.parent.filePath=urls.first
            print(self.parent.filePath)
            self.parent.appendToNavPath()
            controller.dismiss(animated: true)
        }
    }
}

//#Preview {
//    @Previewable @State var path:URL=URL(fileURLWithPath: "/pdf")!
//    DocumentPicker(filePath:$path)
//    
//}
