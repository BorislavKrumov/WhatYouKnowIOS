//
//  PublicHelpViewController.swift
//  WhatYouKnow
//
//  Created by Borislav on 5.05.22.
//

import UIKit
class PublicHelpViewController : UIViewController,PopupDelegate{
    @IBOutlet weak var publicView: UIView!
    @IBOutlet weak var labelAnswer1: UILabel!
    @IBOutlet weak var labelAnswer2: UILabel!
    @IBOutlet weak var labelAnswer3: UILabel!
    @IBOutlet weak var labelAnswer4: UILabel!
    private var answer1: String?
    private var answer2: String?
    private var answer3: String?
    private var answer4: String?
    private var correctAnswer: String?
    var gesture : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateValues(answer1: answer1!, answer2: answer2!, answer3: answer3!, answer4: answer4!, correctAnswer: correctAnswer!)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeView), name: NSNotification.Name("CloseView"), object: nil)


        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        view.addGestureRecognizer(gesture)
        self.gesture = gesture
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }    
    
    func populateValues(answer1:String, answer2:String, answer3:String, answer4: String, correctAnswer:String){
        
        var percentage = 100
        var currentPercentage: Int
        if(answer1 == correctAnswer){
            currentPercentage = Int.random(in: 1...35) + 35
            percentage -= currentPercentage
            labelAnswer1?.text = answer1 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer2?.text = answer2 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer3?.text = answer3 + ":" + String(currentPercentage)
            + "%"
            labelAnswer4?.text = answer4 + ":" + String(percentage) + "%"
        }
        else if(answer2 == correctAnswer){
            currentPercentage = Int.random(in: 1...35) + 35
            percentage -= currentPercentage
            labelAnswer2?.text = answer2 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer1?.text = answer1 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer3?.text = answer3 + ":" + String(currentPercentage) + "%"
            labelAnswer4?.text = answer4 + ":" + String(percentage) + "%"
        }
        else if(answer3 == correctAnswer){
            currentPercentage = Int.random(in: 1...35) + 35
            percentage -= currentPercentage
            labelAnswer3?.text = answer3 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer2?.text = answer2 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer1?.text = answer1 + ":" + String(currentPercentage) + "%"
            labelAnswer4?.text = answer4 + ":" + String(percentage) + "%"
        }
        else if(answer4 == correctAnswer){
            currentPercentage = Int.random(in: 1...35) + 35
            percentage -= currentPercentage
            labelAnswer4?.text = answer4 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer2?.text = answer2 + ":" + String(currentPercentage) + "%"
            
            currentPercentage = Int.random(in: 1...35)
            percentage -= currentPercentage
            labelAnswer3?.text = answer3 + ":" + String(currentPercentage) + "%"
            labelAnswer1?.text = answer1 + ":" + String(percentage) + "%"
        }
    }
    func popupValuePassed(answer1: String, answer2: String, answer3: String, answer4: String,correctAnswer: String) {
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.correctAnswer = correctAnswer
    }
    

     @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
         let location = tapGestureRecognizer.location(in: publicView)
         guard publicView.isHidden == false,
               !publicView.bounds.contains(location) else {
             return
         }
         self.dismiss(animated: true)
     }
}
