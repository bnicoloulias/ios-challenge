//
//  ContentView.swift
//  Barstool Challenge
//
//  Created by Thomas Rademaker on 1/23/23.
//

import SwiftUI

struct StoriesView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
