//
//  Acessories.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 12/04/23.
//

import SpriteKit

class Acessories: AcessoriesProtocol {
    var node: SKSpriteNode
    var state: StateProtocol

    init(node: SKSpriteNode, state: StateProtocol) {
        self.node = node
        self.state = state
    }
}
