//
//  LocalizedString.swift
//  GoELink
//
//  Created by Yoichi Tagaya on 8/26/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

internal func LocalizedString(key: String, comment: String?) -> String {
    struct Static {
        static let bundle = NSBundle(identifier: "com.github.1stpaygatewayllc.GoELink")!
    }
    return NSLocalizedString(key, bundle: Static.bundle, comment: comment ?? "")
}
