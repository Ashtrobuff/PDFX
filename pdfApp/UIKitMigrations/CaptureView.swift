//
//  CaptureView.swift
//  pdfApp
//
//  Created by Ashish on 01/04/25.
//

import SwiftUI

struct CaptureView: View {
    @State var flashIsOn:Bool=false
    var body: some View {
        ZStack{
            Rectangle().fill(.blue)
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Cancel").foregroundColor(.white)
                    Spacer()
                    Button
                    {
                        flashIsOn.toggle()
                    }label:{
                        Image(systemName:"\(flashIsOn ? "bolt.fill" : "bolt.slash.fill")").foregroundColor(.white)
                    }
                }.padding(.horizontal,20)
                Spacer()
                ZStack{
                    
                    HStack{
                    Circle().fill(.white).frame(width:60,height:60).overlay
                    {
                        Circle().fill(.clear).stroke(.white, style: .init())
                    }
                }
                    Rectangle().fill(.white).frame(width:55,height: 55).cornerRadius(10).shadow(radius: 1).offset(x:(UIScreen.main.bounds.width/2)-30)
            }.padding(.trailing,20)
        }
        }
    }
}

#Preview {
    CaptureView()
}
