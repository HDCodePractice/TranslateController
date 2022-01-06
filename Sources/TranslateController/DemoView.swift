//
//  SwiftUIView.swift
//  
//
//  Created by 老房东 on 2022-01-03.
//

import SwiftUI

struct DemoView: View {
    @State var text = "Hello World"
    @State var show_translate = false
    
    var body: some View {
        ZStack{
            TranslateController(text: text, showing: $show_translate)
                .frame(width: 0, height: 0)
            Button("Translate"){
                show_translate = true
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
