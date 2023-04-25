//
//  Acessories.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 12/04/23.
//

import SpriteKit

class Accessories: AcessoriesProtocol {
    var node: SKSpriteNode
    var state: StateProtocol

    init(node: SKSpriteNode = SKSpriteNode(), state: StateProtocol) {
        self.node = node
        self.state = state
    }
}
