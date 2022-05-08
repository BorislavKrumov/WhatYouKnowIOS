//
//  NewGameViewController.swift
//  WhatYouKnow
//
//  Created by Borislav on 29.04.22.
//

import UIKit
import CoreData

class NewGameViewController: UIViewController {

    @IBOutlet weak var labelCurrentScore: UILabel!
    //This need to be persisted
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
    
    var animationActive = false
    var animationsDuration = 10
    var delegate: PopupDelegate? = nil
    
    private lazy var persistentContainer: NSPersistentContainer = {
        NSPersistentContainer(name: "Scores")
    }()
    private var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
            
        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
            if let error = error {
                print("Unable to Add Persistent Store")
                print("\(error), \(error.localizedDescription)")

            } else {
                self?.fetchScore()
            }
        }
        // Do any additional setup after loading the view.
        NetworkService.sharedObj.getQuestions{
            (Questions) in
            self.labelCurrentScore.text = String(self.currentScore)
            self.arr = Questions.shuffled()
            self.updateQuestions()
            self.btnAnswer1.addAction(for: .touchUpInside){
                self.checkAnswer(button: self.btnAnswer1, correctAnswer: self.correctAnswer)
            }
            self.btnAnswer2.addAction {
                self.checkAnswer(button: self.btnAnswer2, correctAnswer: self.correctAnswer)
            }
            self.btnAnswer3.addAction(for: .touchUpInside){
                self.checkAnswer(button: self.btnAnswer3, correctAnswer: self.correctAnswer)
            }
            self.btnAnswer4.addAction(for: .touchUpInside){
                self.checkAnswer(button: self.btnAnswer4, correctAnswer: self.correctAnswer)
                
            }
        
            self.btnFiftyFifty.addAction {
                self.btnFiftyFifty.flash {
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
                
            }
        }
    }
    @IBAction func helpFromPublic(_ sender: Any) {
        self.btnCallPublic.flash {
            self.btnCallPublic.isHidden = true
        }
    }
    private func fetchScore() {
        print(persistentContainer.viewContext)
        let fetchRequest: NSFetchRequest<Scores> = Scores.fetchRequest()
        persistentContainer.viewContext.perform {
            do{
            
            let result = try fetchRequest.execute()
                DispatchQueue.main.async {
                    let result = result.last?.highscore
                    self.labelHighestScore.text = result!
                }
                
                print(self.labelHighestScore.text!)
            }
            catch{
                print("Error from fetch request")
            }
        }
    }
    private func updateQuestions() {
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
    
   private func btnVisibilityReset(){
        btnAnswer1.isHidden = false
        btnAnswer2.isHidden = false
        btnAnswer3.isHidden = false
        btnAnswer4.isHidden = false
    }
    private func addPoints() {
        multiplier += 1
        currentScore += 10 + multiplier * Int(3.76)
        labelCurrentScore.text = String(currentScore)
        
        if(currentScore > highestScore){
            managedObjectContext = persistentContainer.viewContext
            guard let managedObjectContext = managedObjectContext else {
                fatalError("No managed object context available")
            }
            let score = Scores(context: managedObjectContext)
            
            score.highscore = String(highestScore)
            
            do{
                try
                managedObjectContext.save()
            }
            catch
            {
                print("Unable to save Book, \(error)")
            }
            highestScore = currentScore
            labelHighestScore.text = String(highestScore)
        }
    }
    private func gameOverScreen(){
        let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "GameOver")
        self.fetchScore()
        self.present(nextViewController, animated: true,completion: nil)
    }
    public func getQuestionsArr()-> Questions{
        return arr!
    }
    
    private func checkAnswer(button: UIButton, correctAnswer:String){
        button.layer.backgroundColor = UIColor.clear.cgColor
        if (button.currentTitle == self.correctAnswer){
            button.pulsate() {
                self.updateQuestions()
                self.addPoints()
            }

        }
        
        else {
                button.shake(){
                self.gameOverScreen()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! PublicHelpViewController
        destinationVc.popupValuePassed(answer1: self.answer1,answer2: self.answer2,answer3: self.answer3,answer4: self.answer4,correctAnswer: self.correctAnswer)
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}


extension UIButton {
    
    func pulsate(_ completion: @escaping ()->()) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
        CATransaction.commit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            completion()
        }
    }
    
    func flash( _ completion: @escaping ()->()) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
        CATransaction.commit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            completion()
    }
    }
    func shake(_ completion: @escaping ()->()) {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
        CATransaction.commit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            completion()
        
    }
    }
}
    

