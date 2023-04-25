//
//  Acessories.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 12/04/23.
//

import SpriteKit

class Accessories: AcessoriesProtocol {
    var node: SKSpriteNode
    var state: AccesoriesStateEnum

    init(node: SKSpriteNode = SKSpriteNode(), state: AccesoriesStateEnum) {
        self.node = node
        self.state = state
    }
}
