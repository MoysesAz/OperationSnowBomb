//
//  InteractProtocol.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import SpriteKit

protocol InteractProtocol {
    var state: StateProtocol { get set }
    var node: SKSpriteNode { get set }
}
