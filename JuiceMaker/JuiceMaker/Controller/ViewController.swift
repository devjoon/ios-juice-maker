//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    let juiceMaker = JuiceMaker()
    
    juiceMaker
    
    @IBOutlet weak var strawberryCount: UILabel!
    @IBOutlet weak var bananaCount: UILabel!
    @IBOutlet weak var pineappleCount: UILabel!
    @IBOutlet weak var kiwiCount: UILabel!
    @IBOutlet weak var mangoCount: UILabel!
    
    @objc func changeStock(_ noti: NSNotification) {
        guard let fruitList = noti.userInfo else {
            return
        }
        
        for (key, stock) in fruitList {
            guard let fruitStock = stock as? Int else {
                return
            }
            switch key as? Fruit {
            case .strawberry:
                strawberryCount.text = String(fruitStock)
            case .banana:
                bananaCount.text = String(fruitStock)
            case .pineapple:
                pineappleCount.text = String(fruitStock)
            case .kiwi:
                kiwiCount.text = String(fruitStock)
            case .mango:
                mangoCount.text = String(fruitStock)
            default:
                break
            }
        }
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        do {
            switch sender.tag {
            case 1:
                try juiceMaker.takeOrder(order: .strawberryJuice)
            case 2:
                try juiceMaker.takeOrder(order: .bananaJuice)
            case 3:
                try juiceMaker.takeOrder(order: .pineappleJuice)
            case 4:
                try juiceMaker.takeOrder(order: .kiwiJuice)
            case 5:
                try juiceMaker.takeOrder(order: .mangoJuice)
            case 6:
                try juiceMaker.takeOrder(order: .strawberryBananaJuice)
            case 7:
                try juiceMaker.takeOrder(order: .mangoKiwiJuice)
            default:
                break
            }
        } catch {
            print("error났어")
        }
    }
    
    @IBAction func goFruitStore(_ sender: UIButton) {
        let JuiceMakerVC = storyboard?.instantiateViewController(identifier: "FruitStoreVC")
        JuiceMakerVC?.modalPresentationStyle = .pageSheet
        JuiceMakerVC?.modalTransitionStyle = .coverVertical
        present(JuiceMakerVC!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeStock(_:)), name: Notification.Name("changeStock"), object: nil)
        //juiceMaker.updateStock()
        //fruitStore에 접근하기 위해선 juiceMaker를 통해야한다.
    }
}
