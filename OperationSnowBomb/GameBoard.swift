//
//  GameBoard.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 11/04/23.
//

import SpriteKit

class GameBoard: SKScene {
    var player: ActorProtocol?

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setup()
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

extension GameBoard {
    private func setupSnowBox() {
        let snowBox = SKSpriteNode(imageNamed: "SnowBox")
        snowBox.size = .init(width: frame.width * 0.10, height: frame.width * 0.10)
        snowBox.position = .init(x: frame.width * 0.90, y: frame.height * 0.10)
        addChild(snowBox)
    }

    private func setupCannon(withIterator number: Int) {
        let sizeCannons:CGSize = .init(width: frame.width * 0.15, height: frame.width * 0.15)

        for iterator in 0...number-1 {
            let positionXMulti = 0.188 + 0.207 * Double(iterator)
            let cannon = Actuator(withName: "Cannon\(iterator + 1)",
                                  waitingTexture: SKTextureAtlas(named:"CannonWaiting"),
                                  disabledTexture: SKTextureAtlas(named:"CannonDisabled"),
                                  enabledTexture: SKTextureAtlas(named:"CannonEnabled"),
                                  position: .init(x: frame.width * positionXMulti ,
                                                  y: frame.height * 0.42),
                                                  size: sizeCannons)
            addChild(cannon)
        }
    }

    private func setupGodolfredo() {
        let waitingTextureAtlas = SKTextureAtlas(named:"GoldofredoWaiting")
        let holdingRawTextureAtlas = SKTextureAtlas(named: "GoldofredoHoldingRaw")
        let holdingRefinedTextureAtlas = SKTextureAtlas(named: "GoldofredohHoldingRefined")

        let godofredo = Actor(
            waitingTexture: waitingTextureAtlas.textureNames.map(SKTexture.init(imageNamed:)),
            holdingRawTexture: holdingRawTextureAtlas.textureNames.map(SKTexture.init(imageNamed:)),
            holdingRefinedTexture: holdingRefinedTextureAtlas.textureNames.map(SKTexture.init(imageNamed:)))

        godofredo.size = .init(width: frame.width * 0.15, height: frame.width * 0.15)
        godofredo.position = .init(x: frame.width * 0.5, y: frame.height * 0.15)
        godofredo.name = "Player"
        self.player = godofredo
        addChild(godofredo)

    }

    private func setupSnow() {
        let iglooWall = SKSpriteNode(imageNamed: "IglooWall")
        iglooWall.size = .init(width: frame.width * 1.05, height: frame.width * 0.20)
        iglooWall.position = .init(x: frame.width * 0.5, y: frame.height * 0.39)
        addChild(iglooWall)
    }

    private func setup() {
        setupSnow()
        setupSnowBox()
        setupGodolfredo()
        setupCannon(withIterator: 4)
    }
}
