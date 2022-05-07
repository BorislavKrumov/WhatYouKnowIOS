//
//  NewGameViewController.swift
//  WhatYouKnow
//
//  Created by Borislav on 29.04.22.
//

import UIKit

class NewGameViewController: UIViewController {

    @IBOutlet weak var labelCurrentScore: UILabel!
    @IBOutlet weak var labelHighestScore: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    @IBOutlet weak var btnCallPublic: UIButton!
    @IBOutlet weak var btnCallFriend: UIButton!
    @IBOutlet weak var btnFiftyFifty: UIButton!
 
    var correctAnswer: String = ""
    var answer1: String = ""
    var answer2: String = ""
    var answer3: String = ""
    var answer4: String = ""

    var multiplier = 0
    var currentScore = 0
    var highestScore = 0
    var currentQuestion = 0
    var arr: Questions!

    var delegate: PopupDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkService.sharedObj.getQuestions{
            (Questions) in
            self.labelCurrentScore.text = String(self.currentScore)
            self.labelHighestScore.text = String(self.highestScore)
            self.arr = Questions.shuffled()
            self.updateQuestions()
            self.btnAnswer1.addAction(for: .touchUpInside){
                if (self.btnAnswer1.currentTitle == self.correctAnswer){
                    self.updateQuestions()
                    self.addPoints()
                }
                
                else {
                    self.gameOverScreen()
                }
            }
            self.btnAnswer2.addAction {
                if (self.btnAnswer2.currentTitle == self.correctAnswer){
                    self.updateQuestions()
                    self.addPoints()
                }
                
                else {
                    self.gameOverScreen()
                }
            }
            self.btnAnswer3.addAction(for: .touchUpInside){
	                if (self.btnAnswer3.currentTitle == self.correctAnswer){
                    self.addPoints()
                    self.updateQuestions()
                }
                
                else {
                    self.gameOverScreen()
                }
            }
            self.btnAnswer4.addAction {
                if (self.btnAnswer4.currentTitle == self.correctAnswer){
                    self.updateQuestions()
                    self.addPoints()
                }
                
                else {
                    self.gameOverScreen()
                }
            }
            self.btnFiftyFifty.addAction {
                self.btnFiftyFifty.isHidden = true
                if (self.btnAnswer1.currentTitle == self.correctAnswer){
                    self.btnAnswer3.isHidden = true
                    self.btnAnswer4.isHidden = true
                }
                else if(self.btnAnswer2.currentTitle == self.correctAnswer){
                    self.btnAnswer4.isHidden = true
                    self.btnAnswer3.isHidden = true
                }
                else if(self.btnAnswer3.currentTitle == self.correctAnswer){
                    self.btnAnswer4.isHidden = true
                    self.btnAnswer2.isHidden = true
                }
                else if(self.btnAnswer4.currentTitle == self.correctAnswer){
                    self.btnAnswer1.isHidden = true
                    self.btnAnswer3.isHidden = true
                }
            }
            
//            self.arr.shuffle()
    }
    }
    func updateQuestions() {
        btnVisibilityReset()
        self.currentQuestion = (currentQuestion + 1) % self.arr.count
        self.answer1 = arr[self.currentQuestion].getAnswer1()
        self.answer2 = arr[self.currentQuestion].getAnswer2()
        self.answer3 = arr[self.currentQuestion].getAnswer3()
        self.answer4 = arr[self.currentQuestion].getAnswer4()
            self.btnAnswer1.setTitle(answer1, for: UIControl.State.normal)
            self.btnAnswer2.setTitle(answer2, for: UIControl.State.normal)
            self.btnAnswer3.setTitle(answer3, for: UIControl.State.normal)
            self.btnAnswer4.setTitle(answer4, for: UIControl.State.normal)
            self.labelQuestion.text = arr[self.currentQuestion].getQuestion()
            self.correctAnswer = arr[self.currentQuestion].getCorrectAnswer()
    }
    
    func btnVisibilityReset(){
        btnAnswer1.isHidden = false
        btnAnswer2.isHidden = false
        btnAnswer3.isHidden = false
        btnAnswer4.isHidden = false
    }
    func addPoints() {
        multiplier += 1
        currentScore += 10 + multiplier * Int(3.76)
        labelCurrentScore.text = String(currentScore)
        
        if(currentScore > highestScore){
            highestScore = currentScore
            labelHighestScore.text = String(highestScore)
            
        }
    }
    func gameOverScreen(){
        let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "GameOver")
        self.present(nextViewController, animated: true,completion: nil)
    }
    public func getQuestionsArr()-> Questions{
        return arr!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! PublicHelpViewController
        destinationVc.popupValuePassed(answer1: self.answer1,answer2: self.answer2,answer3: self.answer3,answer4: self.answer4,correctAnswer: self.correctAnswer)
//        helpFromPublic(Any?.self)
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}

