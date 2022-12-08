//
//  ViewController.swift
//  QuizGame
//
//  Created by Justin Gluska on 12/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    // sets randomQuestion globally which will store the current question we are working with
    var randomQuestion: (question: String, answers: [String], correctAnswer: Int)!
    
    // amount of points user has
    var userScore: Int = 0
    
    // amount of strikes user has
    var userStrikes: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Generates a new question, fills in label & buttons
        newQuestion()

        // Set the numberOfLines property of the questionLabel to 0
        // to allow the label to use as many lines as needed to display its text
        questionLabel.numberOfLines = 0

        // Set the lineBreakMode property of the questionLabel to .byWordWrapping
        // to wrap the label's text by word instead of by character
        questionLabel.lineBreakMode = .byWordWrapping

    }

    // label keeping track of score
    @IBOutlet weak var scoreLabel: UILabel!
    // label displaying the question
    @IBOutlet weak var questionLabel: UILabel!
    
    // outlets to set answer text (on the buttons)
    @IBOutlet weak var answerAoutlet: UIButton!
    @IBOutlet weak var answerBoutlet: UIButton!
    @IBOutlet weak var answerCoutlet: UIButton!
    @IBOutlet weak var answerDoutlet: UIButton!
    
    // answer button click functions 0-3
    // corresponding to answer choices 1-4
    @IBAction func answerAclicked(_ sender: Any) {
        checkAnswer(selectedAnswer: 0)
    }
    
    @IBAction func answerBclicked(_ sender: Any) {
        checkAnswer(selectedAnswer: 1)
    }
    
    @IBAction func answerCclicked(_ sender: Any) {
        checkAnswer(selectedAnswer: 2)
    }
    
    @IBAction func answerDclicked(_ sender: Any) {
        checkAnswer(selectedAnswer: 3)
    }
    
    // quiz data structure with question, answers, and corresponding correct answer
    // correctAnswer is the index in the answers for the correct answer
    let quiz = [(
            question: "What is the capital of France?",
            answers: [
                "Berlin",
                "Rome",
                "Paris",
                "London"],
            correctAnswer: 2
        ),
        (
            question: "Who is the current president of the United States?",
            answers: [
                "Joe Biden",
                "Donald Trump",
                "Barack Obama",
                "George Washington"
            ],
            correctAnswer: 0
        ),
        (
            question: "What is the largest planet in our solar system?",
            answers: [
                "Earth",
                "Mars",
                "Jupiter",
                "Saturn"
            ],
            correctAnswer: 2
        )
    ]
    
    // Assume that `questionLabel` is a UILabel object that has been configured
    // in your user interface and is connected to your view controller class
    // via an outlet.
    
    func checkAnswer(selectedAnswer: Int) {
        // Compare the selected answer to the correct answer
        if selectedAnswer == randomQuestion.correctAnswer {
            // If the selected answer is correct, display a message to the user
            print("Correct!")
            userScore += 5
        } else {
            // If the selected answer is incorrect, display a message to the user
            print("Incorrect. The correct answer is: \(randomQuestion.answers[randomQuestion.correctAnswer])")
            userScore -= 3
            // add a strike on incorrect
            userStrikes += 1
        }
        //generate a new question, move forward with game
        /// move this function to the correctAnswer if statement above if you only want to move forward with a correct response
        newQuestion()
    }
    
    func newQuestion() {
        //check if user is eliminated
        if(userStrikes >= 3){
            print("LOSE GAME!")
        }
        // update user score on app
        scoreLabel.text = "\(userScore)"
        // Select a random question from the quiz array
        randomQuestion = quiz.randomElement()!

        // Set the text of the questionLabel to the text of the random question
        questionLabel.text = randomQuestion.question
        // set button titles with corresponding answers
        answerAoutlet.setTitle(randomQuestion.answers[0], for: .normal)
        answerBoutlet.setTitle(randomQuestion.answers[1], for: .normal)
        answerCoutlet.setTitle(randomQuestion.answers[2], for: .normal)
        answerDoutlet.setTitle(randomQuestion.answers[3], for: .normal)
    }

}

