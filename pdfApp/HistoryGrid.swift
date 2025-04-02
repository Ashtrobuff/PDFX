//
//  HistoryGrid.swift
//  pdfApp
//
//  Created by Ashish on 31/03/25.
//

import SwiftUI

struct HistoryGrid: View {
    var body: some View {
        let columns=Array(repeating: GridItem(.flexible()), count: 3)
        ScrollView(.vertical){
        LazyVGrid(columns:columns)
        {
            ForEach(0..<20)
            {
                i in
                NavigationLink{
                    Text("\(i)")
                }label:{
                ThumbnailPDF()
            }
            }
        }
        }
    }
}

#Preview {
    HistoryGrid()
}
