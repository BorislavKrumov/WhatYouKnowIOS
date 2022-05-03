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
    @IBOutlet weak var labelCurrentQuestion: UILabel!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    @IBOutlet weak var btnCallPublic: UIButton!
    @IBOutlet weak var btnCallFriend: UIButton!
    @IBOutlet weak var btnFiftyFifty: UIButton!
    
    
    @IBOutlet weak var labelQuestion: UILabel!
    var correctAnswer: String = ""
    var currentQuestion = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkService.sharedObj.getQuestions{
            (Questions) in
            self.btnAnswer1.setTitle(Questions[self.currentQuestion].getAnswer1(), for: UIControl.State.normal)
            self.btnAnswer2.setTitle(Questions[self.currentQuestion].getAnswer2(), for: UIControl.State.normal)
            self.btnAnswer3.setTitle(Questions[self.currentQuestion].getAnswer3(), for: UIControl.State.normal)
            self.btnAnswer4.setTitle(Questions[self.currentQuestion].getAnswer4(), for: UIControl.State.normal)
            self.labelQuestion.text = Questions[self.currentQuestion].getQuestion()
            
            self.correctAnswer = Questions[self.currentQuestion].getCorrectAnswer()
            self.btnAnswer1.addAction(for: .touchUpInside){
                if (self.btnAnswer1.currentTitle == self.correctAnswer){
                    print("Correct Answer")
                    self.updateQuestions()
                    print(self.currentQuestion)
                }
                
                else {
                    print("Wrong answer!")
                }
            }
            
            self.btnAnswer3.addAction(for: .touchUpInside){
                if (self.btnAnswer3.currentTitle == self.correctAnswer){
                    self.updateQuestions()
                }
                
                else {
                    print("Wrong answer!")
                }
            }
    }
    }
    func updateQuestions() {
        self.currentQuestion+=1
        NetworkService.sharedObj.getQuestions{
            (Questions) in
            self.btnAnswer1.setTitle(Questions[self.currentQuestion].getAnswer1(), for: UIControl.State.normal)
            self.btnAnswer2.setTitle(Questions[self.currentQuestion].getAnswer2(), for: UIControl.State.normal)
            self.btnAnswer3.setTitle(Questions[self.currentQuestion].getAnswer3(), for: UIControl.State.normal)
            self.btnAnswer4.setTitle(Questions[self.currentQuestion].getAnswer4(), for: UIControl.State.normal)
            self.labelQuestion.text = Questions[self.currentQuestion].getQuestion()
            self.correctAnswer = Questions[self.currentQuestion].getCorrectAnswer()
        }
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
