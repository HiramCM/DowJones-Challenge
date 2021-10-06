//
//  RepositoryTask.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
