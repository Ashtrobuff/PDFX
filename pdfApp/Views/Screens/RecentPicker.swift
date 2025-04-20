//
//  RecentPicker.swift
//  pdfApp
//
//  Created by Ashish on 13/04/25.
//

import SwiftUI

struct RecentPicker: View {
    @Binding var navPath:NavigationPath
    @Binding var pdfArr:[PDFModel]
    @EnvironmentObject var rcf:RecentFileObject
    let columns:Array=Array(repeating: GridItem(.flexible()), count: 3)
    @State var selectedItems:[PDFModel]=[]
    var body: some View {
        VStack{
            Spacer()
            HStack{
            Text("Recent Files").font(.system(size: 20)).fontWeight(.bold).padding(.bottom,10)
                Spacer()
            }.padding(.horizontal,10).padding(.top,30)
            if(rcf.pdfArr.isEmpty)
            {
                VStack{Spacer()
                
                Text("There are no recent Files :(")
                Spacer()
            }
            }else{
                ScrollView{
                    LazyVGrid(columns:columns,spacing: 10)
                    {
                        ForEach(rcf.pdfArr)
                        {
                            i in
                            
                            CustomPDFPicker(model:i,Datecreated: "45/27/233", pdfArr:$selectedItems).frame(maxWidth: .infinity)
                            
                        }
                    }
                }.padding(.horizontal,20).padding(.top,5).onAppear{
                    
                }.onDisappear{
                    pdfArr.append(contentsOf: selectedItems)
                }
            }
        }.navigationTitle("Recent Files")
    }
}
//
//#Preview {
//    RecentPicker()
//}
