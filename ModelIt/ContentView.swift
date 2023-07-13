//
//  ContentView.swift
//  ModelIt
//
//  Created by HouPeihong on 2023/7/13.
//

import SwiftUI

func setup()
{
    let pipeline = Pipeline_Create()
    Pipeline_CameraInit(pipeline)
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("CameraInit") {
                setup()
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
