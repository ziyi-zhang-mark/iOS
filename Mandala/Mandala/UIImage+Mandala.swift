//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Ziyi Zhang on 10/30/22.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    convenience init(resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
}
