//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Uy Cung Dinh on 5/29/19.
//  Copyright © 2019 Equity. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses: [Answer]!
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult() {
        var answerFrequency = [AnimalType: Int]()
        let responseTypes = responses.map { $0.type }
        for type in responseTypes {
            answerFrequency[type] = (answerFrequency[type] ?? 0) + 1
        }
        let answerFrequencySorted = answerFrequency.sorted(by:
        { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        let mostCommonAnswer = answerFrequencySorted.first!.key
        animalLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        definitionLabel .text = "\(mostCommonAnswer.definition)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
