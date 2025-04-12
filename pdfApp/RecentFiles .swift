//
//  RecentFiles .swift
//  pdfApp
//
//  Created by Ashish on 12/04/25.
//

import SwiftUI
import PDFKit
struct RecentFiles_: View {

    @EnvironmentObject var rcf:RecentFileObject
    let column=Array(repeating: GridItem(.flexible()), count: 3)
    var body: some View {
        VStack{
            HStack{
                Text("Recent Files").fontWeight(.bold)
                Spacer()}.padding(.leading,10)
            ScrollView{
                LazyVGrid(columns:column)
                {
                    ForEach($rcf.pdfArr)
                    {
                        i in
                        PDFThumbSquare(model:i, Datecreated:"22/34/22")
                    }
                    
                }.onAppear{
                }.frame(maxHeight:300)
            }.frame(height:400).background(.background.secondary)
        }
        
        
    }


}
   
//#Preview {
//    RecentFiles_()
//}
