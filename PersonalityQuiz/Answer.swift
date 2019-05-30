//
//  Answer.swift
//  PersonalityQuiz
//
//  Created by Uy Cung Dinh on 5/29/19.
//  Copyright © 2019 Equity. All rights reserved.
//

import Foundation
struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .rabbit:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}
