//
//  DummyResponse.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 11/30/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

@testable import GoELinkModel
@testable import GoELinkViewModel

let dummyResponse: ResponseEntity = {
    let contact0 = ContactEntity(
        first_name: "Bryan",
        last_name:"Hudson",
        objectId: "QdQGHXs016",
        profileURL: "https://s3.amazonaws.com/goelink/resources/images/placeholder.png")
    let contact1 = ContactEntity(
        first_name: "Sandra",
        last_name:"Watson",
        objectId: "s67vyA4gBS",
        profileURL: "https://s3.amazonaws.com/goelink/resources/images/placeholder.png"
        )
    return ResponseEntity(results: [contact0, contact1])
}()

let image1x1: UIImage = {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), true, 0)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}()
