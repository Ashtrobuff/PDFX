//
//  WaterFinalGridScreen.swift
//  pdfApp
//
//  Created by Ashish on 14/04/25.
//

import SwiftUI

struct WaterFinalGridScreen: View {
    var pdfArr:[PDFModel]?
    let columns=Array(repeating: GridItem(.flexible()), count: 3)
    var body: some View {
        VStack{
           
            ScrollView{
                LazyVGrid(columns:columns){
                    ForEach(self.pdfArr!)
                    {
                        i in
                        NavigationLink{
                            WaterViewFinal(pdfDoc: i.pdfDoc)
                        }label:{
                        PDFThumbSquare(model: i, Datecreated: "22/34/2003")}
                    }
                }
            }
        }.navigationTitle("Watermarked PDFs").toolbar(id:"watermark.grid"){
            ToolbarItem(id:"Export",placement: .primaryAction){
                Button{print("export All")}label:{
                    Text("Export All")
                }
            }
            ToolbarItem(id:"Discard",placement: .secondaryAction){
                Button{print("Discard")}label:{
                    Text("Discard")
                }
            }
        }.toolbarRole(.navigationStack)
    }
}

#Preview {
    WaterFinalGridScreen()
}
