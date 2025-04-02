//
//  HomePage.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI

struct HomePage: View {
   @State var selectedItem:Int=0
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack{
                    ZStack{
                        
                        HStack
                        {   NavigationLink{
                            Text("settings Page")
                        }label:{
                            Image(systemName: "ellipsis").rotationEffect(.degrees(90)).foregroundStyle(.white)
                        }
                            Spacer()
                            Text("PDFX").fontDesign(.monospaced).foregroundColor(.white)
                            Spacer()
                            
                        }.padding(.horizontal,20)
                    }.frame(width:UIScreen.main.bounds.width,height:60).background(Color.mint)
                    HStack{
                        Text("Recents").font(.largeTitle).multilineTextAlignment(.leading).fontWeight(.bold)
                        Spacer()}.padding(.horizontal,20)
                    switch selectedItem
                    {
                    case 0:
                        HistoryGrid().padding(.vertical,0).background(.clear)
                    case 1:
                        
                       ActionPage()
                            Spacer()
                        
                    case 2:
                        Text("message")
                        Spacer()
                    case 3:
                        Text("ellipsis")
                        Spacer()
                    default:
                        HistoryGrid().padding(.vertical,0).background(.clear)
                    }
                   
                }
                Spacer()
                ZStack{
                    
                    Rectangle().fill(.white).frame(width:UIScreen.main.bounds.width-10,height:50).cornerRadius(30).offset(y:370).shadow(radius: 1)
                    HStack{
                        Image(systemName:"house")
                            .onTapGesture {
                                withAnimation{
                                    self.selectedItem=0
                                }
                            }
                        Spacer()
                        Image(systemName:"gear") .onTapGesture {
                            withAnimation{
                            self.selectedItem=1}
                        }
                        Spacer()
                        Image(systemName:"message")
                            .onTapGesture {
                                withAnimation{
                                    self.selectedItem=2
                                }
                            }
                        Spacer()
                        Image(systemName:"ellipsis").rotationEffect(.degrees(90))
                            .onTapGesture {
                                withAnimation{
                                selectedItem=3
                            }
                            }
                    }.offset(y:370).padding(.horizontal,30)
            }
                
        }
    }
    }
}

#Preview {
    HomePage()
}
