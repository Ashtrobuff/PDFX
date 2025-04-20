//
//  DocScanner.swift
//  pdfApp
//
//  Created by Ashish on 06/04/25.
//

import SwiftUI

import VisionKit

struct DocScanner: UIViewControllerRepresentable {
    @Binding var scanResult: [UIImage]
    @Binding var navpath:NavigationPath
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        documentCameraViewController.view.backgroundColor = .black
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
   
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scanResult: $scanResult,parent:self)
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent:DocScanner?
        @Binding var scanResult: [UIImage]
        init(scanResult: Binding<[UIImage]>,parent:DocScanner) {
            _scanResult = scanResult
            self.parent=parent
        }
        
        /// Tells the delegate that the user successfully saved a scanned document from the document camera.
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            controller.dismiss(animated: true, completion: nil)
            scanResult = (0..<scan.pageCount).compactMap { scan.imageOfPage(at: $0) }
            var arrt:[imageHasher]=[]
            for i in 0..<scanResult.count
            {
                let imageHash=imageHasher(image: scanResult[i])
                arrt.append(imageHash)
            }
            
            let method=scanHasher(images: arrt)
            DispatchQueue.main.asyncAfter(deadline:.now()+3){
                    self.parent?.navpath.append(method)
                }
        }
        
        // Tells the delegate that the user canceled out of the document scanner camera.
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
     
            controller.dismiss(animated: true, completion: nil)
            parent?.dismiss()
        }
        
        /// Tells the delegate that document scanning failed while the camera view controller was active.
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document scanner error: \(error.localizedDescription)")
            controller.dismiss(animated: true, completion: nil)
        }
        
    }
}
