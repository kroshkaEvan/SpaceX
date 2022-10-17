//
//  Entity+CoreDataProperties.swift
//  SpaceX
//
//  Created by Эван Крошкин on 17.10.22.
//
//

import Foundation
import CoreData


extension RocketModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketModel> {
        return NSFetchRequest<RocketModel>(entityName: "Rocket")
    }

    @NSManaged public var firstFlight: String?
    @NSManaged public var stages: Int
    @NSManaged public var name: String?
    @NSManaged public var active: Bool
    @NSManaged public var images: String?

}

extension RocketModel : Identifiable {

}
