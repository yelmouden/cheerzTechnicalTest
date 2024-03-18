//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation

public enum LoadingState<T: Equatable>: Equatable {
    case loading
    case loaded(T)
    case error
}
