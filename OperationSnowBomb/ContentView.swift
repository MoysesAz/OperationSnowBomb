//
//  ContentView.swift
//  OperationSnowBomb
//
//  Created by Moyses Miranda do Vale Azevedo on 31/03/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = GameBoard()
        scene.scaleMode = .resizeFill
        return scene
    }
    var body: some View {
        GeometryReader { frame in
            SpriteView(scene: scene)
                .frame(width: frame.size.width, height: frame.size.height, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
