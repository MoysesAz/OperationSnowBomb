//
//  GameBoard.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 11/04/23.
//

import SpriteKit

class GameBoard: SKScene {
    var player: Actor
    var snowBox: Accessories

    internal init(player: Actor, snowBox: Accessories) {
        self.player = player
        self.snowBox = snowBox
        super.init(size: .init(width: 0, height: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .systemBlue
        setup()
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
//        guard var player = player else {
//            return print()
//        }
//        self.player?.moveDifference = CGPoint(x: location.x - player.position.x,
//                                              y: location.y - player.position.y)
//
//        if player.moveDifference.x < 0 {
//            player.multiplierForDirection = -1.0
//            player.animationActor()
//            player.moveToLeft(location: location)
//        } else {
//            player.multiplierForDirection = 1.0
//            player.animationActor()
//            player.moveToRight(location: location)
//        }
//
//        player.xScale = abs(player.xScale) * player.multiplierForDirection
    }
}

extension GameBoard {
    private func setupSnowBox() {
        snowBox.node.size = .init(width: frame.width * 0.10, height: frame.width * 0.10)
        snowBox.node.position = .init(x: frame.width * 0.90, y: frame.height * 0.129)
        snowBox.node.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 0.10,
                                                               height: frame.width * 0.10))
        snowBox.node.physicsBody?.isDynamic = false
        snowBox.node.physicsBody?.affectedByGravity = false
        addChild(self.snowBox.node)
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
        self.player.node.size = .init(width: frame.width * 0.15, height: frame.width * 0.15)
        self.player.node.position = .init(x: frame.width * 0.5, y: frame.height * 0.15)
        self.player.node.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 0.15,
                                                                 height: frame.width * 0.15))
        self.player.node.physicsBody?.affectedByGravity = false
        self.player.node.physicsBody?.isDynamic = true
        self.player.node.physicsBody?.allowsRotation = false
        self.player.node.physicsBody?.categoryBitMask = 0b0001
        self.player.node.physicsBody?.contactTestBitMask = 0b0010
        addChild(self.player.node)
    }

    private func setupSnow() {
        let iglooWall = SKSpriteNode(imageNamed: "IglooWall")
        iglooWall.size = .init(width: frame.width * 1.05, height: frame.width * 0.20)
        iglooWall.position = .init(x: frame.width * 0.5, y: frame.height * 0.39)
        iglooWall.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 1.05,
                                                                 height: frame.width * 0.20))
        iglooWall.physicsBody?.isDynamic = false
        iglooWall.physicsBody?.affectedByGravity = false
        addChild(iglooWall)
    }

    private func setupSnowMachine() {
        let snowMachine = SKSpriteNode(imageNamed: "SnowMachine")
        snowMachine.size = .init(width: frame.width * 0.18, height: frame.width * 0.18)
        snowMachine.position = .init(x: frame.width * 0.18, y: frame.height * 0.129)
        addChild(snowMachine)
    }

    private func setup() {
        self.physicsWorld.contactDelegate = self
        setupSnow()
        setupSnowMachine()
        setupSnowBox()
        setupGodolfredo()
        setupCannon(withIterator: 4)
    }
}

extension GameBoard: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("A:", contact.bodyA.node?.name ?? "no node")
        print("B:", contact.bodyB.node?.name ?? "no node")

//        self.player?.state = ActorStateEnum.holding(projectile: .rawMaterial)
//        self.player?.animationActor()
//        if contact.bodyB == obstacle.physicsBody {
//            print("Sophia Cat foi de arrasta pra cima")
//            character.run(
//                SKAction.sequence([
//                    SKAction.fadeOut(withDuration: 0.5),
//                    SKAction.fadeIn(withDuration: 0.5)
//                ])
//            )
//        }
    }
}
