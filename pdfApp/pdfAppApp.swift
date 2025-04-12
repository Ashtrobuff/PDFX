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
            }.navigationDestination(for: PDFKitView.self)
                {
                    v in
                    v
                }
        }.onAppear{
            rcf.loadlocalFiles()
        }
        }.environmentObject(waterMarkString)
            .environmentObject(rcf)
        .environmentObject(viewModelfactory)
        
    }
}
