//
//  SoloSetApp.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import SwiftUI

@main
struct SoloSetApp: App
{
    @StateObject var game = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: game)
        }
    }
}
