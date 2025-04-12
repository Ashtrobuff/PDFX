//
//  ActionItem.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI

struct ActionItem: View,Identifiable {
    var id:UUID=UUID()
    var ActionImage:Image
    var Title:String
    var description:String
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    ActionImage.foregroundColor(.black).cornerRadius(10).frame(width:30,height:30)
                    Spacer()
                    NavigationLink{
                        Text(Title)
                    }label:{
                        Image(systemName:"arrow.up.right").foregroundColor(.secondary)
                    }
                }
           
                Spacer()
        }.padding(5)
            VStack{
                Spacer()
                HStack{
                Text(Title).font(.caption).fontWeight(.medium).multilineTextAlignment(.leading).foregroundColor(.secondary)
                    Spacer()
            }
            }.padding(.bottom,5).padding(.leading,5)

        }.frame(width:110,height: 110).background(Color.white).cornerRadius(10).overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.5), lineWidth: 0.5)
        }.shadow(radius: 0.5)
    }
}

#Preview {
    ActionItem(ActionImage: Image(systemName:"photo.circle.fill"),Title:"Photo to PDF", description:"Convert a photo to PDF Document")
}
