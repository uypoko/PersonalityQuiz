//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Uy Cung Dinh on 5/29/19.
//  Copyright © 2019 Equity. All rights reserved.
//

import Foundation
struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}
