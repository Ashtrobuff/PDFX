//
//  ThumbnailPDF.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI

struct ThumbnailPDF: View {
    var body: some View {
        ZStack{
            VStack{
                Rectangle().frame()
                VStack{
                    Text("Ashish.pdf")
                    HStack{
                        Spacer()
                        Text("9 pages").foregroundColor(.secondary).font(.footnote)
                        NavigationLink{
                            Text("this is my pdf")
                        }label:{
                        Image(systemName:"ellipsis").rotationEffect(.degrees(90)).foregroundColor(.secondary)
                    }
                    }.padding(.trailing,10)
                }
               
                Spacer()
            }
        }.frame(width:100,height:140).background(Color.white)
            .cornerRadius(20).shadow(radius: 1)
    }
}

#Preview {
    ThumbnailPDF()
}
