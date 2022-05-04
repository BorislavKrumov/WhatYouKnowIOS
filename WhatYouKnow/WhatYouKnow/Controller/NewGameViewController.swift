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
    
    @IBOutlet weak var labelPossibility1: UILabel!
    @IBOutlet weak var labelPossibility2: UILabel!
    @IBOutlet weak var labelPossibility3: UILabel!
    @IBOutlet weak var labelPossibility4: UILabel!
    var correctAnswer: String = ""
    var multiplier = 0
    var currentScore = 0
    var highestScore = 0
    var currentQuestion = 0
    var arr: Questions!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelCurrentScore.text = String(currentScore)
        labelHighestScore.text = String( highestScore)
        NetworkService.sharedObj.getQuestions{
            (Questions) in
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
            self.btnAnswer1.setTitle(arr[self.currentQuestion].getAnswer1(), for: UIControl.State.normal)
            self.btnAnswer2.setTitle(arr[self.currentQuestion].getAnswer2(), for: UIControl.State.normal)
            self.btnAnswer3.setTitle(arr[self.currentQuestion].getAnswer3(), for: UIControl.State.normal)
            self.btnAnswer4.setTitle(arr[self.currentQuestion].getAnswer4(), for: UIControl.State.normal)
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
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
