//
//  ActionListView.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI

struct ActionListView: View {
    @State var isLoading=true
    var actionList:[ActionItem]=[ActionItem(ActionImage: Image(systemName:"arrow.trianglehead.merge"), Title: "Merge PDFs", description: "merge multiple PDFs into one."),ActionItem(ActionImage: Image(systemName:"photo"), Title: "Images to PDF", description: "Images from Gallery to PDF"),ActionItem(ActionImage: Image(systemName:"square.split.diagonal"), Title: "Split PDFs", description: " ")]
    var body: some View {
        ZStack{
            if(isLoading)
            {
                ProgressView()
                     .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                     .scaleEffect(2.0, anchor: .center)
            }else{
            VStack{
                ScrollView{
                    ForEach(actionList)
                    {
                        i  in
                        i
                    }
                }
            }
        }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2 ){
            
                    isLoading=false
                
              
                  }
        }
    }
}

#Preview {
    ActionListView()
}
