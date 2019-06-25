//
//  Created by Czajka, Kamil
//

import Foundation

internal class EntityValidatorImpl : EntityValidator {
    internal func validate<Entity>(_ entity: Entity?) -> Entity where Entity : Decodable, Entity : Encodable {
        guard let validEntity = entity else {
            fatalError("Entity is nil")
        }
        return validEntity
    }
    
    
}
