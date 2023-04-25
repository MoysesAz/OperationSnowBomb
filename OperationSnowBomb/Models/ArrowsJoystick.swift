//
//  ArrowsJoystick.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 25/04/23.
//

import Foundation
import SpriteKit

class ArrowsJoystick: SKNode {

//    var upArrow:Bool = false
//    var downArrow:Bool = false
//    var rightArrow:Bool = false
//    var leftArrow:Bool = false
    var circle:SKShapeNode!
    var upArrow:SKShapeNode!
    var downArrow:SKShapeNode!
    var rightArrow:SKShapeNode!
    var leftArrow:SKShapeNode!

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
