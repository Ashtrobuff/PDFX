//
//  pdfAppApp.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI
import SwiftData
import PDFKit
@main

struct pdfAppApp: App {
    @ObservedObject var router = Router()
    @StateObject var mergevm=MergeViewModel()
    @StateObject var waterMarkString = WaterMarkViewModel()
    @StateObject var rcf = RecentFileObject()
    let viewModelfactory=ViewModelFactory()

init()
    {
        
    }
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack(path:$router.navPath){
            ZStack{
                HomePage(navPath: $router.navPath)
            }.background(.black).navigationDestination(for: PDFHashed.self)
                {
                    v in
                   
                    MergeViewFinal(pdfDoc: v.pdfDoc)
                    
                }
                .navigationDestination(for: PDFWaterHasher.self)
                { v in
                    WaterViewFinal(pdfDoc: v.pdfDoc)
                }
                .navigationDestination(for: NavigationDestinationsEnum.self)
                { screen in
                    switch screen {
                    case .WaterMark:
                        WaterMarkPage(navPath: $router.navPath)
                    
                               }
                    
                }
                .navigationDestination(for: PDFWaterHashArr.self)
                {
                    item in
                    
                    WaterFinalGridScreen(pdfArr: item.pdfArr)
                }
                .navigationDestination(for: String.self)
                {
                    item in
                    
                    Text("\(item)")
                }
                .navigationDestination(for: scanHasher.self)
                {
                    item in
                    
                    ScanView(images: item.images,navPath:$router.navPath)
                }
                
        }.onAppear{
            rcf.loadlocalFiles()
        }
        }.environmentObject(waterMarkString)
            .environmentObject(rcf)
        .environmentObject(viewModelfactory)
        
    }
}
