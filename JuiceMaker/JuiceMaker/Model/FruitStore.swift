//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

// 과일 저장소 타입
class FruitStore {
    var fruitList: [String:Int] = ["딸기":100, "바나나":0, "파인애플":100, "키위":100, "망고":100]
    
    func plusQuantity(productName: String, quantity: Int) throws {
        guard let remainingProductQuantity = fruitList[productName] else {
            throw InputError.wrongInput
        }
        fruitList[productName] = remainingProductQuantity + quantity
    }
    
    func minusQuantity(productName: String, quantity: Int) throws {
        guard let remainingProductQuantity = fruitList[productName] else {
            throw InputError.wrongInput
        }
        fruitList[productName] = remainingProductQuantity - quantity
    }
    
}

let firstFruitStore = FruitStore()
