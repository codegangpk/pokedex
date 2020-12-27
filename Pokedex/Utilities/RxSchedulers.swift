//
//  RxSchedulers.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/28.
//

import Foundation
import RxSwift

struct RxSchedulers {
    static let main = MainScheduler.instance
    
    static let globalUserInitiated = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
}

