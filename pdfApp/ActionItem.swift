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
                    ActionImage.foregroundColor(.white).padding(5).background(Color.blue).cornerRadius(10)
                    Spacer()
                    NavigationLink{
                        Text(Title)
                    }label:{
                        Image(systemName:"arrow.up.right")
                    }
                }
                HStack{
                    Text(Title).font(.caption).fontWeight(.heavy).multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack{
                Text(description).font(.footnote).multilineTextAlignment(.leading)
                    Spacer()
            }
        }.padding(5)
        }.frame(width:110,height: 110).background(Color.white).cornerRadius(10).shadow(radius: 1)
    }
}

#Preview {
    ActionItem(ActionImage: Image(systemName:"photo.circle.fill"),Title:"Photo to PDF", description:"Convert a photo to PDF Document")
}
