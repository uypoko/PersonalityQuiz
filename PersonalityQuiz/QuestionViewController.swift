//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Uy Cung Dinh on 5/29/19.
//  Copyright © 2019 Equity. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var questionIndex = 0
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type:.single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                    ]),
        Question(text: "Which activities do you enjoy?",
                type: .multiple,
                answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
                    ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous",
                           type: .rabbit),
                    Answer(text: "I barely notice them",
                           type: .turtle),
                    Answer(text: "I love them", type: .dog)
                    ])
        ]
    var answersChosen = [Answer]()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multiSwitch: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedBeginLabel: UILabel!
    @IBOutlet weak var rangedEndLabel: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        navigationItem.title = "Question #\(questionIndex+1)"
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex+1) / Float(questions.count)
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        for (index, button) in singleButtons.enumerated() {
            button.setTitle(answers[index].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        for sw in multiSwitch {
            sw.isOn = false
        }
        for (index, label) in multipleLabels.enumerated() {
            label.text = answers[index].text
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedBeginLabel.text = answers.first?.text
        rangedEndLabel.text = answers.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    @IBAction func singleButtonTapped(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        if let chosenIndex = singleButtons.firstIndex(of: sender) {
            answersChosen.append(currentAnswers[chosenIndex])
        }
        nextQuestion()
    }
    
    @IBAction func multipleSubmitButtonTapped(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        for (index, sw) in multiSwitch.enumerated() {
            if sw.isOn {
                answersChosen.append(currentAnswers[index])
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedSubmitButtonTapped(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
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
