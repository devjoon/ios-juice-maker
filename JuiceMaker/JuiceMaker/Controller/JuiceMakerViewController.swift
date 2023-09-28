//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

protocol manageStockDelegate {
    func updateStock(fruitList: [Fruit: Int]) // 특수 - 서브뷰컨 값을 적용시키기 위함.
    func refreshAllStock()
    func refreshStock(fruit: Fruit, stock: Int)
}

final class JuiceMakerViewController: UIViewController, manageStockDelegate {
    @IBOutlet var fruitCountLabels: [UILabel]!
    private let juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruitCountLabels.sort(by: {$0.tag < $1.tag})
        configureDelegate()
        refreshAllStock()
    }
    
    private func configureDelegate() {
        juiceMaker.fruitStore.delegate = self
    }
    
    func updateStock(fruitList: [Fruit: Int]) {
        juiceMaker.fruitStore.updateStock(modifiedList: fruitList)
    }
    
    func refreshAllStock() {
        for (index, label) in fruitCountLabels.enumerated() {
            guard let fruit = Fruit(rawValue: index) else {
                return
            }
            guard let fruitStock = juiceMaker.fruitStore.fruitList[fruit] else {
                return
            }
            
            label.text = String(fruitStock)
        }
    }
    
    func refreshStock(fruit: Fruit, stock: Int) {
        fruitCountLabels[fruit.rawValue].text = String(stock)
    }
    
    @IBAction private func touchUpInsideOrderButton(_ sender: UIButton) {
        guard let menu = Menu(rawValue: sender.tag) else {
            return
        }
        
        do {
            try juiceMaker.takeOrder(order: menu)
            completeAlert(menu: menu)
        } catch {
            failureAlert()
        }
    }
    
    private func completeAlert(menu: Menu) {
        let alert = UIAlertController(title: "\(menu.explainKorean) \(AlertTitle.served.rawValue)", message: AlertMessage.enjoy.rawValue, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: AlertTitle.yes.rawValue, style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func failureAlert() {
        let alert = UIAlertController(title: AlertTitle.lackIngredient.rawValue, message: AlertMessage.updateStock.rawValue, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: AlertTitle.yes.rawValue, style: .default) { action in
            self.presentFruitStore()
        })
        alert.addAction(UIAlertAction(title: AlertTitle.no.rawValue, style: .default, handler: nil))
    
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func touchUpInsidePresentFruitStore() {
        presentFruitStore()
    }
    
    private func presentFruitStore() {
        guard let fruitStoreViewController = storyboard?.instantiateViewController(identifier: String(describing: FruitStoreViewController.self)) as? FruitStoreViewController else {
            return
        }
        
        fruitStoreViewController.modalPresentationStyle = .pageSheet
        fruitStoreViewController.modalTransitionStyle = .coverVertical

        fruitStoreViewController.delegate = self
        fruitStoreViewController.fruitList = juiceMaker.fruitStore.fruitList
        
        present(fruitStoreViewController, animated: true)
    }
}
