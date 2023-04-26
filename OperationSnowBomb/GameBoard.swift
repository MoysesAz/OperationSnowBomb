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
    var iglooWall: SKSpriteNode = SKSpriteNode(imageNamed: "IglooWall")
    var background: SKSpriteNode = SKSpriteNode(imageNamed: "backgroundSnowBomb")
    let arrowsJoystick: ArrowsJoystick = ArrowsJoystick()
    var cannons: [Cannon] = []
    let actButton = SKShapeNode(circleOfRadius: 50)
    let innerCircle = SKShapeNode(circleOfRadius: 25)
    var alphaBegan:CGFloat = 1
    var alphaEnded:CGFloat = 0.8

    let actionTVOSButton = UIControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let tapGestureRecognizer = UITapGestureRecognizer(target: GameBoard.self, action: #selector(handleTap))
    @objc func handleTap(sender: UIControl) {
        player.moveToLeftJoystick()
    }

    #if os(iOS)
    let impactGenerator = UIImpactFeedbackGenerator(style: .light)
    #endif

    internal init(player: Actor,
                  snowBox: Accessories,
                  snowMachine: SnowMachine
    ) {
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

        actionTVOSButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        view.addSubview(actionTVOSButton)

        super.didMove(to: view)
        arrowsJoystick.position = .init(x: frame.width * 0.1, y: frame.height * 0.74)
        addChild(arrowsJoystick)
        setup()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let delta = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)

        let node = self.atPoint(location)
        if node == actButton || node == innerCircle {
            actButton.alpha = alphaEnded
            innerCircle.alpha = alphaEnded
        }

        let limiteMovement: CGFloat = 4.8
        if abs(delta.x) >= limiteMovement || abs(delta.y) >= limiteMovement {
            switch node {
            case arrowsJoystick.leftArrow:
                arrowsJoystick.arrowUnpressed(nodePlayer: player)
            case arrowsJoystick.rightArrow:
                arrowsJoystick.arrowUnpressed(nodePlayer: player)
            case arrowsJoystick.upArrow:
                arrowsJoystick.arrowUnpressed(nodePlayer: player)
            case arrowsJoystick.downArrow:
                arrowsJoystick.arrowUnpressed(nodePlayer: player)
            default:
                break
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self)

        let node = self.atPoint(location)
        if node == actButton || node == innerCircle {
            actButton.alpha = alphaBegan
            innerCircle.alpha = alphaBegan
            #if os(iOS)
            impactGenerator.impactOccurred()
            #endif
            print("botao funcionando")
        }

        switch node {
        case arrowsJoystick.leftArrow:
            arrowsJoystick.leftArrowIsActive = true
            arrowsJoystick.arrowPressed(nodePlayer: player)
            arrowsJoystick.setSpriteOrientation(arrow: "left", nodePlayer: player)
            player.multiplierForDirection = -1.0
        case arrowsJoystick.rightArrow:
            arrowsJoystick.rightArrowIsActive = true
            arrowsJoystick.arrowPressed(nodePlayer: player)
            arrowsJoystick.setSpriteOrientation(arrow: "right", nodePlayer: player)
        case arrowsJoystick.upArrow:
            arrowsJoystick.upArrowIsActive = true
            arrowsJoystick.arrowPressed(nodePlayer: player)
        case arrowsJoystick.downArrow:
            arrowsJoystick.downArrowIsActive = true
            arrowsJoystick.arrowPressed(nodePlayer: player)
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
            arrowsJoystick.arrowUnpressed(nodePlayer: player)
        case arrowsJoystick.rightArrow:
            arrowsJoystick.arrowUnpressed(nodePlayer: player)
        case arrowsJoystick.upArrow:
            arrowsJoystick.arrowUnpressed(nodePlayer: player)
        case arrowsJoystick.downArrow:
            arrowsJoystick.arrowUnpressed(nodePlayer: player)
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
    private func setupBackground() {
        background.zPosition = -1
        background.size = .init(width: frame.width, height: frame.height)
        background.position = .init(x: frame.width * 0.5, y: frame.height * 0.5)
    }

    private func setupSnowBox() {
        snowBox.node.size = .init(width: frame.width * 0.10, height: frame.width * 0.10)
        snowBox.node.position = .init(x: frame.width * 0.90, y: frame.height * 0.129)
        snowBox.node.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 0.10,
                                                                    height: frame.width * 0.10))
    }

    private func setupCannon(withIterator number: Int) {
                let sizeCannons:CGSize = .init(width: frame.width * 0.15, height: frame.width * 0.15)
                var categoryCannon: [UInt32] = [0b0001000, 0b0010000, 0b0100000, 0b1000000]

                for iterator in 0...number-1 {
                    let positionXMulti = 0.188 + 0.207 * Double(iterator)
                    let cannon = Factory().cannon()
                    cannon.node.position = .init(x: frame.width * positionXMulti, y: frame.height * 0.45)
                    cannon.node.size = sizeCannons
                    cannon.node.physicsBody = SKPhysicsBody(rectangleOf: sizeCannons)
                    cannon.node.physicsBody?.isDynamic = false
                    cannon.node.physicsBody?.affectedByGravity = false
                    cannon.node.physicsBody?.categoryBitMask = categoryCannon[iterator]
                    cannons.append(cannon)
                    addChild(cannon.node)
                }
    }

    private func setupGodolfredo() {
        self.player.node.size = .init(width: frame.width * 0.15, height: frame.width * 0.15)
        self.player.node.position = .init(x: frame.width * 0.5, y: frame.height * 0.15)
        self.player.node.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 0.15,
                                                                        height: frame.width * 0.15))
    }

    private func setupIglooWall() {
        iglooWall.size = .init(width: frame.width * 1.05, height: frame.width * 0.20)
        iglooWall.position = .init(x: frame.width * 0.5, y: frame.height * 0.39)
        iglooWall.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 1.05,
                                                                 height: frame.height * 0.03))
    }

    private func setupSnowMachine() {
        snowMachine.node.size = .init(width: frame.width * 0.18, height: frame.width * 0.18)
        snowMachine.node.position = .init(x: frame.width * 0.18, y: frame.height * 0.18)
        snowMachine.node.physicsBody = SKPhysicsBody(rectangleOf: .init(width: frame.width * 0.18,
                                                                        height: frame.width * 0.18))
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

    private func addChilds() {
        addChild(background)
        addChild(iglooWall)
        addChild(player.node)
        addChild(snowBox.node)
        addChild(snowMachine.node)
    }

    private func setup() {
        self.physicsWorld.contactDelegate = self
        setupBackground()
        setupSnowBox()
        setupSnowMachine()
        setupGodolfredo()
        setupIglooWall()
        basicPhysics()
        setupCollisions()
        addChilds()
        setupCannon(withIterator: 4)
        setupJoystick()
    }
}

extension GameBoard {
    private func basicPhysics() {
        snowMachine.node.physicsBody?.isDynamic = false
        snowMachine.node.physicsBody?.affectedByGravity = false

        snowBox.node.physicsBody?.isDynamic = false
        snowBox.node.physicsBody?.affectedByGravity = false

        iglooWall.physicsBody?.isDynamic = false
        iglooWall.physicsBody?.affectedByGravity = false
        iglooWall.physicsBody?.pinned = true

        player.node.physicsBody?.affectedByGravity = false
        player.node.physicsBody?.isDynamic = true
        player.node.physicsBody?.allowsRotation = false
    }

    private func setupCollisions() {
        let categoryPlayer: UInt32      = 0b0000001
        let categorySnowBox: UInt32     = 0b0000010
        let categorySnowMachine: UInt32 = 0b0000100
        let categoryCannon0: UInt32     = 0b0001000
        let categoryCannon1: UInt32     = 0b0010000
        let categoryCannon2: UInt32     = 0b0100000
        let categoryCannon3: UInt32     = 0b1000000


        // 0b0010
        // 0b0100
        // 0b0110

        snowMachine.node.physicsBody?.categoryBitMask = categorySnowMachine
        snowBox.node.physicsBody?.categoryBitMask = categorySnowBox
        player.node.physicsBody?.categoryBitMask = categoryPlayer
        self.player.node.physicsBody?.contactTestBitMask = categorySnowBox + categorySnowMachine + categoryCannon0 + categoryCannon1 + categoryCannon2 + categoryCannon3 // sem essa merda nada funciona
    }
}
