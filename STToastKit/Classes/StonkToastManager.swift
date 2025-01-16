//
//  StonkToastManager.swift
//  StonkIOS
//
//  Created by admin on 2022/8/5.
//

import Foundation

/// 管理吐司
class StonkToastManager {
    
    static let shared = StonkToastManager()
    
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    private init() {
        
    }
    
    func addToast(_ toast:StonkToast) {
        self.queue.cancelAllOperations()
        self.queue.addOperation(toast)
    }
    
}
