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
        indentifyPlayerDirections(location: location)
    }
}

extension GameBoard {
    private func indentifyPlayerDirections(location: CGPoint) {
        guard var player = player else {
            return print()
        }
        self.player?.moveDifference = CGPoint(x: location.x - player.position.x,
                                              y: location.y - player.position.y)

        if player.moveDifference.x < 0 {
            player.multiplierForDirection = -1.0
            player.animationActor()
            player.moveToLeft(location: location)
        } else {
            player.multiplierForDirection = 1.0
            player.animationActor()
            player.moveToRight(location: location)
        }

        player.xScale = abs(player.xScale) * player.multiplierForDirection
    }
}
