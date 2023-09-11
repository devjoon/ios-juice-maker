//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

// 쥬스 메이커 타입
struct JuiceMaker {
    func checkMenu(juiceName:String) throws {
        switch juiceName {
            //st, ba, ki, pi, stba, ma, maki
        case "st":
            do {
                try checkIngredient(itemName: "딸기",need: 16)
                try firstFruitStore.minusQuantity(productName: "딸기", quantity: 16)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        case "ba":
            do {
                try checkIngredient(itemName: "바나나",need: 2)
                try firstFruitStore.minusQuantity(productName: "바나나", quantity: 2)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        case "ki":
            do {
                try checkIngredient(itemName: "키위",need: 3)
                try firstFruitStore.minusQuantity(productName: "키위", quantity: 3)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        case "pi":
            do {
                try checkIngredient(itemName: "파인애플",need: 2)
                try firstFruitStore.minusQuantity(productName: "파인애플", quantity: 2)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        case "stba":
            do {
                try checkIngredient(itemName: "딸기",need: 10)
                try checkIngredient(itemName: "바나나",need: 1)
                try firstFruitStore.minusQuantity(productName: "딸기", quantity: 10)
                try firstFruitStore.minusQuantity(productName: "바나나", quantity: 10)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        case "ma":
            do {
                try checkIngredient(itemName: "망고",need: 3)
                try firstFruitStore.minusQuantity(productName: "망고", quantity: 3)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        case "maki":
            do {
                try checkIngredient(itemName: "망고",need: 2)
                try checkIngredient(itemName: "키위",need: 1)
                try firstFruitStore.minusQuantity(productName: "망고", quantity: 2)
                try firstFruitStore.minusQuantity(productName: "키위", quantity: 1)
            } catch {
                print("재료 부족")
                throw InputError.lackIngredient
            }
        default:
            throw InputError.noMenu
        }
    }
    
    func checkIngredient(itemName:String, need:Int) throws {
        guard let remainingProductQuantity = firstFruitStore.fruitList[itemName] else {
            throw InputError.wrongInput
        }
        guard remainingProductQuantity >= need else {
            throw InputError.lackIngredient
        }
    }
    
}

let firstJuiceMaker = JuiceMaker()

//func playGame() {
//    while true {
//        print("원하시는 매뉴선택 1. 재료확인 , 2. 쥬스제작 : ",terminator: "")
//        guard let a = readLine() else {
//            print("잘못된입력")
//            return
//        }
//
//        if a == "1" {
//            print(firstFruitStore.fruitList)
//        }
//        if a == "2" {
//            do {
//                print("""
//            -------------------------------
//            원하시는 쥬스를 선택해주세요
//            -------------------------------
//            딸기쥬스 : 딸기 16개 소모
//            바나나쥬스 : 바나나 2개 소모
//            키위쥬스 : 키위 3개 소모
//            파인애플 쥬스 : 파인애플 2개 소모
//            딸바쥬스 : 딸기 10개 + 바나나 1개 소모
//            망고 쥬스 : 망고 3개 소모
//            망고키위 쥬스 : 망고 2개 + 키위 1개 소모
//            --------------------------------
//            여기에 영어로 과일이름 입력 (st, ba, ki, pi, stba, ma, maki) :
//            """,terminator: " ")
//                guard let b = readLine() else {
//                    print("잘못된입력")
//                    return
//                }
//                print(b)
//                try firstJuiceMaker.checkMenu(juiceName: b)
//                print("\(b) 제작완료")
//            } catch {
//                print("제작 실패")
//            }
//        }
//    }
//}
//
//playGame()

