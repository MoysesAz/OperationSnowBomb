//
//  ContentView.swift
//  OperationSnowBomb
//
//  Created by Moyses Miranda do Vale Azevedo on 31/03/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var factory = Factory()

    var scene: SKScene {
        let scene = GameBoard(player: factory.godofredo(),
                              snowBox: factory.snowBox(),
                              snowMachine: factory.snowMachine()
        )
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
