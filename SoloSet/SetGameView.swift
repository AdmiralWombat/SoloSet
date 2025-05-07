//
//  ContentView.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import SwiftUI

struct SetGameView: View
{
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View
    {
        VStack {
           
        }
        .padding()
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
