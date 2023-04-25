//
//  GameBoard.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 11/04/23.
//

import SpriteKit
import SwiftUI

class GameBoard: SKScene {
    var player: Actor
    var snowBox: Accessories
    var snowMachine: SnowMachine
    let arrowsJoystick: ArrowsJoystick = ArrowsJoystick()
    let actButton = SKShapeNode(circleOfRadius: 50)
    let innerCircle = SKShapeNode(circleOfRadius: 25)
    var alphaBegan:CGFloat = 1
    var alphaEnded:CGFloat = 0.8
//    let impactGenerator = UIImpactFeedbackGenerator(style: .light)

    internal init(player: Actor, snowBox: Accessories, snowMachine: SnowMachine) {
        self.player = player
        self.snowBox = snowBox
        self.snowMachine = snowMachine
        super.init(size: .init(width: 0, height: 0))
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        arrowsJoystick.position = .init(x: frame.width * 0.1, y: frame.height * 0.74)
        addChild(arrowsJoystick)
        setup()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self)

        let node = self.atPoint(location)
        if node == actButton || node == innerCircle {
            actButton.alpha = alphaBegan
            innerCircle.alpha = alphaBegan
//            impactGenerator.impactOccurred()
            print("botao funcionando")
        }

        switch node {
        case arrowsJoystick.leftArrow:
            arrowsJoystick.leftArrow.fillColor = .darkGray
            arrowsJoystick.circle.alpha = 1
            player.multiplierForDirection = -1.0
            player.animationActor()
            player.moveToLeftJoystick()
            player.node.xScale = abs(player.node.xScale) * player.multiplierForDirection
        case arrowsJoystick.rightArrow:
            arrowsJoystick.rightArrow.fillColor = .darkGray
            arrowsJoystick.circle.alpha = 1
            player.multiplierForDirection = 1.0
            player.animationActor()
            player.moveToRightJoystick()
            player.node.xScale = abs(player.node.xScale) * player.multiplierForDirection
        case arrowsJoystick.upArrow:
            arrowsJoystick.upArrow.fillColor = .darkGray
            arrowsJoystick.circle.alpha = 1
            player.animationActor()
            player.moveToUpJoystick()
        case arrowsJoystick.downArrow:
            arrowsJoystick.downArrow.fillColor = .darkGray
            arrowsJoystick.circle.alpha = 1
            player.animationActor()
            player.moveToDownJoystick()
        default:
            break
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        if node == actButton || node == innerCircle {
            actButton.alpha = alphaEnded
            innerCircle.alpha = alphaEnded
        }

        switch node {
        case arrowsJoystick.leftArrow:
            arrowsJoystick.circle.alpha = 0.5
            arrowsJoystick.leftArrow.fillColor = .gray
        case arrowsJoystick.rightArrow:
            arrowsJoystick.circle.alpha = 0.5
            arrowsJoystick.rightArrow.fillColor = .gray
        case arrowsJoystick.upArrow:
            arrowsJoystick.circle.alpha = 0.5
            arrowsJoystick.upArrow.fillColor = .gray
        case arrowsJoystick.downArrow:
            arrowsJoystick.circle.alpha = 0.5
            arrowsJoystick.downArrow.fillColor = .gray
        default:
            break
        }
    }
}

extension GameBoard {
    private func indentifyPlayerDirections(location: CGPoint) {
        self.player.moveDifference = CGPoint(x: location.x - player.node.position.x,
                                             y: location.y - player.node.position.y)

        if player.moveDifference.x < 0 {
            player.multiplierForDirection = -1.0
            player.animationActor()
            player.moveToLeft(location: location)
        } else {
            player.multiplierForDirection = 1.0
            player.animationActor()
            player.moveToRight(location: location)
        }

        player.node.xScale = abs(player.node.xScale) * player.multiplierForDirection
    }
}

extension GameBoard {
    private func backgroundArctic() {
//        let backgroundArctic = SKSpriteNode(imageNamed: "backgroundSnowBomb")
//        backgroundArctic.zPosition = -1
//        backgroundArctic.size = .init(width: frame.width, height: frame.height)
//        backgroundArctic.anchorPoint = .init(x: 0.5, y: 0.5)
//        addChild(backgroundArctic)
    }

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
        //        let sizeCannons:CGSize = .init(width: frame.width * 0.15, height: frame.width * 0.15)
        //
        //        for iterator in 0...number-1 {
        //            let positionXMulti = 0.188 + 0.207 * Double(iterator)
        //            let cannon = Actuator(withName: "Cannon\(iterator + 1)",
        //                                  waitingTexture: SKTextureAtlas(named:"CannonWaiting"),
        //                                  disabledTexture: SKTextureAtlas(named:"CannonDisabled"),
        //                                  enabledTexture: SKTextureAtlas(named:"CannonEnabled"),
        //                                  position: .init(x: frame.width * positionXMulti ,
        //                                                  y: frame.height * 0.42),
        //                                                  size: sizeCannons)
        //            addChild(cannon)
        //        }
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
                                                                 height: frame.height * 0.03))
        iglooWall.physicsBody?.affectedByGravity = false
        iglooWall.physicsBody?.allowsRotation = false
        iglooWall.physicsBody?.pinned = true

        addChild(iglooWall)
    }

    private func setupSnowMachine() {
        snowMachine.node.size = .init(width: frame.width * 0.18, height: frame.width * 0.18)
        snowMachine.node.position = .init(x: frame.width * 0.18, y: frame.height * 0.129)
        snowMachine.node.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 0.18,
                                                                        height: frame.width * 0.18))
        snowMachine.node.physicsBody?.isDynamic = false
        snowMachine.node.physicsBody?.affectedByGravity = false
        addChild(snowMachine.node)
    }

    private func setupJoystick() {
        innerCircle.fillColor = UIColor.darkGray
        innerCircle.strokeColor = .clear
        innerCircle.position = CGPoint(x: actButton.frame.midX, y: actButton.frame.midY)

        actButton.fillColor = UIColor.lightGray
        actButton.lineWidth = 2
        actButton.strokeColor = UIColor.clear
        actButton.position = .init(x: frame.width * 0.91, y: frame.height * 0.74)
        actButton.alpha = 0.5
        addChild(actButton)
        actButton.addChild(innerCircle)
    }
//    func setupArrowsJoystick() {
//        arrowsJoystick.circleNode = SKShapeNode(circleOfRadius: 90)
//        arrowsJoystick.circleNode.position = .init(x: frame.width * 0.1, y: frame.height * 0.74)
//        arrowsJoystick.circleNode.fillColor = .lightGray
//        arrowsJoystick.circleNode.alpha = alphaBegan
//        arrowsJoystick.circleNode.zPosition = 2
//
//        arrowsJoystick.leftArrow = SK
//        arrowsJoystick.leftArrowNode.position = CGPoint(x: arrowsJoystick.circleNode.frame.minX , y: arrowsJoystick.circleNode.frame.midY)
//        arrowsJoystick.leftArrowNode.fillColor = .lightGray
//        arrowsJoystick.leftArrowNode.alpha = alphaBegan
//        arrowsJoystick.leftArrowNode.zPosition = 2

//        arrowsJoystick.rightArrowNode.position =
//        arrowsJoystick.rightArrowNode.fillColor = .lightGray
//        arrowsJoystick.rightArrowNode.alpha = alphaBegan
//        arrowsJoystick.rightArrowNode.zPosition = 2
//
//        arrowsJoystick.downArrowNode.position =
//        arrowsJoystick.downArrowNode.fillColor = .lightGray
//        arrowsJoystick.downArrowNode.alpha = alphaBegan
//        arrowsJoystick.downArrowNode.zPosition = 2
//
//        arrowsJoystick.upArrowNode.position =
//        arrowsJoystick.upArrowNode.fillColor = .lightGray
//        arrowsJoystick.upArrowNode.alpha = alphaBegan
//        arrowsJoystick.upArrowNode.zPosition = 2

//        addChild(arrowsJoystick.circleNode)
//    }

    private func setup() {
        self.physicsWorld.contactDelegate = self
        setupSnow()
        setupSnowMachine()
        setupSnowBox()
        setupGodolfredo()
        setupCannon(withIterator: 4)
        setupCollisions()
        backgroundArctic()
        setupJoystick()
//        setupArrowsJoystick()
    }
}

extension GameBoard: SKPhysicsContactDelegate {
    private func setupCollisions() {
        let categoryPlayer: UInt32 = 0b0001
        let categorySnowBox: UInt32 = 0b0010
        let categorySnowMachine: UInt32 = 0b0011

        snowMachine.node.physicsBody?.categoryBitMask = categorySnowMachine
        snowBox.node.physicsBody?.categoryBitMask = categorySnowBox
        player.node.physicsBody?.categoryBitMask = categoryPlayer

    }
    func didBegin(_ contact: SKPhysicsContact) {
        let categoryPlayer: UInt32 = 0b0001
        let categorySnowBox: UInt32 = 0b0010
        let categorySnowMachine: UInt32 = 0b0011

        let firstBody = contact.bodyA
        let secondBody = contact.bodyB

        let playerInSnowBox = (firstBody.categoryBitMask == categoryPlayer && secondBody.categoryBitMask == categorySnowBox) ||
        (firstBody.categoryBitMask == categorySnowBox && secondBody.categoryBitMask == categoryPlayer)

        let playerInSnowMachine = (firstBody.categoryBitMask == categoryPlayer && secondBody.categoryBitMask == categorySnowMachine) ||
        (firstBody.categoryBitMask == categorySnowMachine && secondBody.categoryBitMask == categoryPlayer)

        if playerInSnowBox && (player.state == .waiting) {
            self.player.state = ActorStateEnum.holding(projectile: .rawMaterial)
            self.player.animationActor()
        }

        if playerInSnowMachine && (player.state == .holding(projectile: .rawMaterial)) {
            self.player.state = .waiting
            self.player.animationActor()

            self.snowMachine.state = .enabled
            self.snowMachine.turnOn()
        }

        //        self.snowMachine.turnOn()

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
