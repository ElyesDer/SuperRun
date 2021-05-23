//
//  Bool+Env.swift
//  SuperRun
//
//  Created by DerouicheElyes on 23/5/2021.
//

import Foundation

extension Bool {
    static var isIphone: Bool {
        #if os(watchOS)
        return false
        #else
        return true
        #endif
    }
}
