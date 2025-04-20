//
//  BottomButtonArray.swift
//  pdfApp
//
//  Created by Ashish on 13/04/25.
//

import SwiftUI

//struct BottomButtonArray: View {
//    @State var showImporter:Bool=false
//    @State var recentSelector:Bool=false
//    @Binding var navpath:NavigationPath
//    @Binding var pdfArr:[PDFModel]
//    var action:Voi{}
//    var body: some View {
//        VStack{
//            Spacer()
//            HStack{
//               Spacer()
//            Button{
//                recentSelector.toggle()
//            }label:{
//                Label{
//                    Text("select from Recents")
//                }icon: {
//                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
//                }
//            }
//            .controlSize(.large).tint(.blue).buttonStyle(.bordered).sheet(isPresented: $recentSelector)
//            {
//                RecentPicker(navPath: $navpath,pdfArr: $pdfArr)
//            }
//                Button{
//                    
//                    showImporter.toggle()
//                }label:{
//                    Label{
//                        Text("Select from Files")
//                    }icon:{
//                        Image(systemName:"folder")
//                    }
//                } .controlSize(.large).tint(.blue).buttonStyle(.bordered)
//                Spacer()
//            }
//            Button{
//                    DispatchQueue.global(qos: .userInitiated).async
//                    {
//                        let pdf=mergevm.mergePDFs()
//                        let pdfview=PDFKitView(pdfDocument: pdf,getWaterMark: false)
//                   
//                        DispatchQueue.main.asyncAfter(deadline: .now()+2)
//                        {
//                            navpath.append(PDFHashed(pdfDoc: pdf!))
//                        }
//                        
//                    }
//            }label:{
//                ZStack{
//                    RoundedRectangle(cornerRadius: 10).frame(maxHeight:55)
//                    Text(mergevm.pdfArr.isEmpty ? "Select PDFs":"Merge PDFs").foregroundColor(.white)
//                }.padding()
//            } .disabled(mergevm.pdfArr.isEmpty)
//        }
//    }
//}

//#Preview {
//    BottomButtonArray()
//}
