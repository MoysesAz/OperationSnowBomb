//
//  GameBoard.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 11/04/23.
//

import SpriteKit

class GameBoard: SKScene {
    var player: ActorProtocol?

    private func setupGodolfredo() {
        let waitingTextureAtlas = SKTextureAtlas(named:"GoldofredoWaiting")
        let holdingRawTextureAtlas = SKTextureAtlas(named: "GoldofredoHoldingRaw")
        let holdingRefinedTextureAtlas = SKTextureAtlas(named: "GoldofredohHoldingRefined")

        let godofredo = Actor(
            waitingTexture: waitingTextureAtlas.textureNames.map(SKTexture.init(imageNamed:)),
            holdingRawTexture: holdingRawTextureAtlas.textureNames.map(SKTexture.init(imageNamed:)),
            holdingRefinedTexture: holdingRefinedTextureAtlas.textureNames.map(SKTexture.init(imageNamed:)))

        godofredo.size = .init(width: frame.width * 0.15, height: frame.width * 0.15)
        godofredo.position = .init(x: frame.width * 0.5, y: frame.height * 0.5)
        godofredo.name = "Player"
        self.player = godofredo
        self.addChild(godofredo)
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupGodolfredo()
        backgroundColor = .red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self)
        print(self.player!)
    }
}
