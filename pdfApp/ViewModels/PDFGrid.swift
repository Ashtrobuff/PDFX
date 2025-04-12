//
//  PDFGrid.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import SwiftUI

struct PDFGrid: View {
    @State var PDFItems:[String]=["mypdf","myName","this is it"]
    var body: some View {
        List($PDFItems,id:\.self, editActions:.move)
        {
            epi in
            Text("\(epi.wrappedValue)")
        }
    }
}

#Preview {
    PDFGrid()
}
