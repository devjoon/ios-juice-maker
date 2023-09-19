//
//  Menu.swift
//  JuiceMaker
//
//  Created by hisop, morgan on 2023/09/12.
//

enum Menu: Int {
    case strawberryJuice = 1
    case bananaJuice = 2
    case kiwiJuice = 3
    case pineappleJuice = 4
    case mangoJuice = 5
    case strawberryBananaJuice = 6
    case mangoKiwiJuice = 7
    
    var menuToString: String {
        switch self.rawValue {
        case 1:
            return "strawberryJuice"
        case 2:
            return "bananaJuice"
        case 3:
            return "kiwiJuice"
        case 4:
            return "pineappleJuice"
        case 5:
            return "mangoJuice"
        case 6:
            return "strawberryBananaJuice"
        case 7:
            return "mangoKiwiJuice"
        default:
            return ""
        }
    }
}

