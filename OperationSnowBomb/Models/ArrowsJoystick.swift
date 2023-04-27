//
//  ArrowsJoystick.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 25/04/23.
//

import Foundation
import SpriteKit

class ArrowsJoystick: SKNode {

    var upArrowIsActive:Bool = false
    var downArrowIsActive:Bool = false
    var rightArrowIsActive:Bool = false
    var leftArrowIsActive:Bool = false

    var circle:SKShapeNode!
    var upArrow:SKShapeNode!
    var downArrow:SKShapeNode!
    var rightArrow:SKShapeNode!
    var leftArrow:SKShapeNode!

//    let actor: Actor = Actor()

    func arrowUnpressed(nodePlayer: Actor) {
        nodePlayer.moveEnd()
        circle.alpha = 0.5

        rightArrow.fillColor = .gray
        rightArrowIsActive = false

        leftArrow.fillColor = .gray
        leftArrowIsActive = false

        upArrow.fillColor = .gray
        upArrowIsActive = false

        downArrow.fillColor = .gray
        downArrowIsActive = false
    }
    func arrowPressed(nodePlayer: Actor) {
        nodePlayer.animationActor()
        switch true {
        case upArrowIsActive:
            buttonAnimations(arrow:"up")
            nodePlayer.moveToUpJoystick()
        case downArrowIsActive:
            buttonAnimations(arrow:"down")
            nodePlayer.moveToDownJoystick()
        case rightArrowIsActive:
            buttonAnimations(arrow:"right")
            nodePlayer.moveToRightJoystick()
        case leftArrowIsActive:
            buttonAnimations(arrow:"left")
            nodePlayer.moveToLeftJoystick()
        default:
            break
        }
    }

    func setSpriteOrientation(arrow: String, nodePlayer: Actor){
        switch arrow {
        case "left":
            nodePlayer.multiplierForDirection = -1.0
            nodePlayer.node.xScale = abs(nodePlayer.node.xScale) * nodePlayer.multiplierForDirection
        case "right":
            nodePlayer.multiplierForDirection = 1.0
            nodePlayer.node.xScale = abs(nodePlayer.node.xScale) * nodePlayer.multiplierForDirection
        default:
            break
        }
    }

    func buttonAnimations(arrow: String) {
        switch arrow {
        case "left":
            leftArrow.fillColor = .darkGray
            circle.alpha = 1
        case "right":
            rightArrow.fillColor = .darkGray
            circle.alpha = 1
        case "up":
            upArrow.fillColor = .darkGray
            circle.alpha = 1
        case "down":
            downArrow.fillColor = .darkGray
            circle.alpha = 1
        default:
            break
        }
    }



    override init() {
        super.init()

        circle = SKShapeNode(circleOfRadius: 90)
        circle.position = .init(x: frame.width * 0.1, y: frame.height * 0.74)
        circle.fillColor = .lightGray
        circle.alpha = 0.5

        upArrow = SKShapeNode()
        let upArrowPath = CGMutablePath()
        upArrowPath.move(to: CGPoint(x: 0, y: 30))
        upArrowPath.addLine(to: CGPoint(x: 20, y: 0))
        upArrowPath.addLine(to: CGPoint(x: -20, y: 0))
        upArrowPath.addLine(to: CGPoint(x: 0, y: 30))
        upArrow.position = .init(x: circle.frame.midX, y: circle.frame.height * 0.2)
        upArrow.path = upArrowPath
        upArrow.fillColor = UIColor.gray
        upArrow.strokeColor = UIColor.clear

        downArrow = SKShapeNode()
        let downArrowPath = CGMutablePath()
        downArrowPath.move(to: CGPoint(x: 0, y: -30))
        downArrowPath.addLine(to: CGPoint(x: 20, y: 0))
        downArrowPath.addLine(to: CGPoint(x: -20, y: 0))
        downArrowPath.addLine(to: CGPoint(x: 0, y: -30))
        downArrow.position = .init(x: circle.frame.midX, y: circle.frame.height * -0.2)
        downArrow.path = downArrowPath
        downArrow.fillColor = UIColor.gray
        downArrow.strokeColor = UIColor.clear

        leftArrow = SKShapeNode()
        let leftArrowPath = CGMutablePath()
        leftArrowPath.move(to: CGPoint(x: -30, y: 0))
        leftArrowPath.addLine(to: CGPoint(x: 0, y: 20))
        leftArrowPath.addLine(to: CGPoint(x: 0, y: -20))
        leftArrowPath.addLine(to: CGPoint(x: -30, y: 0))
        leftArrow.position = .init(x: circle.frame.width * -0.2, y: circle.frame.midY)
        leftArrow.path = leftArrowPath
        leftArrow.fillColor = UIColor.gray
        leftArrow.strokeColor = UIColor.clear

        rightArrow = SKShapeNode()
        let rightArrowPath = CGMutablePath()
        rightArrowPath.move(to: CGPoint(x: 30, y: 0))
        rightArrowPath.addLine(to: CGPoint(x: 0, y: 20))
        rightArrowPath.addLine(to: CGPoint(x: 0, y: -20))
        rightArrowPath.addLine(to: CGPoint(x: 30, y: 0))
        rightArrow.path = rightArrowPath
        rightArrow.position = .init(x: circle.frame.width * 0.2, y: circle.frame.midY)
        rightArrow.fillColor = UIColor.gray
        rightArrow.strokeColor = UIColor.clear

        addChild(circle)
        circle.addChild(upArrow)
        circle.addChild(downArrow)
        circle.addChild(leftArrow)
        circle.addChild(rightArrow)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
