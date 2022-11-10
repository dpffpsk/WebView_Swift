//
//  ImageTable+CoreDataProperties.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/11/10.
//
//

import Foundation
import CoreData


extension ImageTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageTable> {
        return NSFetchRequest<ImageTable>(entityName: "ImageTable")
    }

    @NSManaged public var imageData: Data?

}

extension ImageTable : Identifiable {

}
