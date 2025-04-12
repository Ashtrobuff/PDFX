//
//  EmptyDocsView.swift
//  pdfApp
//
//  Created by Ashish on 08/04/25.
//

import SwiftUI

struct EmptyDocsView: View {
    var body: some View {
        VStack(spacing:30)
        {
            Image(systemName: "light.beacon.min").font(.system(size: 60)).fontWeight(.ultraLight)
            Text("Select PDFs to Merge")
        }
    }
}

#Preview {
    EmptyDocsView()
}
