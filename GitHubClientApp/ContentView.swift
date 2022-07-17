//
//  ContentView.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
                    .padding()
                Text("Good evening, world!")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.orange)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
