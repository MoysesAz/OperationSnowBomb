//
//  InitialScreen.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 26/04/23.
//

import SwiftUI
import SpriteKit

struct InitialScreen: View {

    var factory = Factory()
    @State var isShowingScene = false

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
        ZStack {
            Image("BGInitialScreen")
                .resizable()
                .scaledToFill()

            VStack(alignment: .center, spacing: -280) {
                VStack {
                    Spacer()
                    HStack {
                    }
                }
                Image("LogoInitialScreen")
                    .resizable()
                    .frame(width: 943, height: 487, alignment: .center)
                    .scaledToFit()
                VStack(spacing: -100) {
                    Button(action: {
                        isShowingScene = true
                    }, label: {
                        Image("buttonPlay")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .scaledToFit()
                    }).fullScreenCover(isPresented: $isShowingScene, content: {
                        SpriteView(scene: scene)
                            .ignoresSafeArea()

                    })
                    .transaction({ transaction in
                        transaction.disablesAnimations = true
                    })

                    Button(action: {

                    }, label: {
                        Image("buttonShop")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .scaledToFit()
                            .saturation(0.0)
                    })
                    .disabled(true)

                    Button(action: {

                    }, label: {
                        Image("buttonCredits")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .scaledToFit()
                            .saturation(0.0)
                    })
                    .disabled(true)
                }
            }
        }
    }
}

struct InitialScreen_Previews: PreviewProvider {
    static var previews: some View {
        InitialScreen()
    }
}
