//
//  HomePage.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI
import PDFKit

struct HomePage: View {
   @State var selectedItem:Int=0
   @Binding var navPath:NavigationPath
    @State var showsheet:Bool=false
    @State var images:[UIImage]=[]
    let columns = [GridItem(.flexible(),spacing:5), GridItem(.flexible(),spacing:0),GridItem(.flexible(),spacing:10)]
    var body: some View {
    
            ZStack{
                VStack{
                    LazyVGrid(columns:columns,spacing:10){
                        NavigationLink{
                            MergeView(navpath:$navPath)
                        }label:{
                            ActionItem(ActionImage: Image(systemName: "arrow.trianglehead.merge"), Title: "merge", description: "")
                        }
                        NavigationLink{WaterMarkView(navPath:$navPath)}label:{
                            ActionItem(ActionImage: Image(systemName: "drop"), Title: "WaterMark", description: "")
                        }
                        NavigationLink{CompressView()}label:{
                            ActionItem(ActionImage: Image(systemName: "pencil"), Title: "Edit", description: "")
                        }
                        NavigationLink{DocScanner(scanResult: $images,navpath: $navPath).navigationBarHidden(true)}label:{
                        ActionItem(ActionImage: Image(systemName: "camera"), Title: "Capture", description: "")
                    }
//                        Button{
//                            let view=PDFKitView(pdfDocument:pdfDoc)
//                            navPath.append(view)
//                          
//                        }label:{
//                            Text("doc")
//                        }
                       
                }.padding(10)
                  
                Spacer()
                    RecentFiles_(navPath: $navPath)
                }.padding(0)
            }.background(.white).navigationTitle("Actions").toolbar(id: "options") {
            // this is a primary action, so will always be visible
            ToolbarItem(id: "settings", placement: .primaryAction) {
                Button("Settings") { }
            }

            // this is a standard secondary action, so will be customizable
            ToolbarItem(id: "help", placement: .secondaryAction) {
                Button("Help") { }
            }

            // another customizable button
            ToolbarItem(id: "email", placement: .secondaryAction) {
                Button("Email Me") { }
            }

            // a third customizable button, but this one won't be in the toolbar by default
            ToolbarItem(id: "credits", placement: .secondaryAction, showsByDefault: false) {
                Button("Credits") { }
            }
        }
        .toolbarRole(.navigationStack)
        
        }
    }


#Preview {
    @StateObject var router=Router()
    HomePage(navPath: $router.navPath)
}
