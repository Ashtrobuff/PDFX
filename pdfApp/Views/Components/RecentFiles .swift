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
    @Binding var navPath:NavigationPath
    let column=Array(repeating: GridItem(.flexible(),spacing: 2), count: 3)
    var body: some View {
        VStack{
            HStack{
                Text("Recent Files").fontWeight(.bold)
                Spacer()}.padding(.leading,10)
            VStack{
                ScrollView{
                    LazyVGrid(columns:column)
                    {
                            ForEach(rcf.pdfArr)
                            {
                                doco in
                                PDFThumbSquare(model:doco, Datecreated:"22/34/22").onTapGesture {
                                    navPath.append(PDFHashed(pdfDoc:doco.pdfDoc))
                                }
                            }
                    }.padding(10)
                    
                
                }.frame(maxHeight:.infinity).padding(.top,10)
            
        }
        }
        
        
    }


}
   
//#Preview {
//    RecentFiles_()
//}
