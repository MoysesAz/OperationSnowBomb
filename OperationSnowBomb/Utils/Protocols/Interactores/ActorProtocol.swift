//
//  ActorProtocol.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import Foundation
import SpriteKit

protocol ActorProtocol: ActorMoveProtocol,
                        ActorFeaturesProtocol,
                        ActorTexturesProtocol,
                        InteractProtocol {
    var state: ActorStateEnum { get set }
}
