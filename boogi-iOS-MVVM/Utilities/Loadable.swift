//
//  Loadable.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import SwiftUI

typealias LoadableSubject<Value> = Binding<Loadable<Value>>

enum Loadable<T> {

    case notRequested
//    case isLoading(last: T?, cancelBag: CancelBag)
    case loaded(T)
    case failed(Error)

    var value: T? {
        switch self {
        case let .loaded(value): return value
//        case let .isLoading(last, _): return last
        default: return nil
        }
    }
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
}
