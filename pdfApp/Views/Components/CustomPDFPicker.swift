//
//  CustomPDFPicker.swift
//  pdfApp
//
//  Created by Ashish on 13/04/25.
//

import SwiftUI
struct CustomPDFPicker: View {
    var model: PDFModel
    var Datecreated: String
    @Binding var pdfArr: [PDFModel]
    @State var isSelected: Bool = false {
        didSet {
            if !isSelected {
                pdfArr.removeAll(where: { $0 == self.model })
            } else {
                pdfArr.append(self.model)
            }
        }
    }

    var body: some View {
        ZStack{
        VStack {
            model.pdfThumbnail
                .resizable().scaledToFit().clipped()
            VStack(alignment: .leading) {
                Text("\(model.name)")
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(model.pages) pages")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                        Text("\(Datecreated)")
                            .font(.system(size: 9))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
            
            Button(action: {
                isSelected.toggle()
            }) {
                ZStack{
                    Circle().fill(.clear).stroke(.gray,lineWidth:2).frame(width:20,height:20)
                    Circle().fill(isSelected ? .blue : .clear).frame(width:10,height:10)
                    
                    
                }
            }
        }
        .frame(width: 100, height: 150)
        .padding(.bottom,10).padding(.top,5)
        }.padding(2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.2)
        )        .contentShape(Rectangle()) 
    }
}
