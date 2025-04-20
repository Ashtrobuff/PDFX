//
//  PDFWaterHashArr.swift
//  pdfApp
//
//  Created by Ashish on 14/04/25.
//

import Foundation

struct PDFWaterHashArr:Hashable,Identifiable
{
    var id:UUID
    var pdfArr:[PDFModel]
    
    init(pdfArr: [PDFModel]) {
        self.id = UUID()
        self.pdfArr = pdfArr
    }
}
