//
//  PDFHasher.swift
//  pdfApp
//
//  Created by Ashish on 13/04/25.
//

import Foundation
import PDFKit
struct PDFHashed:Hashable,Equatable
{
    var id:UUID
    var pdfDoc:PDFDocument
    init( pdfDoc: PDFDocument) {
        self.id = UUID()
        self.pdfDoc = pdfDoc
    }
}
