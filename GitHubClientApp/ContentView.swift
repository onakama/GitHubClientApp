//
//  ContentView.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 44.0, height: 44.0)
            VStack(alignment: .leading) {
                Text("Owner Name")
                    .font(.caption)
                    .fontWeight(.semibold)
                Text("Repository Name")
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
