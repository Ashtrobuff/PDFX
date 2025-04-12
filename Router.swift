//
//  Router.swift
//  pdfApp
//
//  Created by Ashish on 03/04/25.
//

import Foundation
import SwiftUI
final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case View
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
