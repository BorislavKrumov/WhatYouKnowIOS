//
//  Question.swift
//  WhatYouKnow
//
//  Created by Borislav on 30.04.22.
//

import Foundation
struct Question: Decodable {
    let questionBank:[QuestionJson]
}
struct QuestionJson: Decodable {
    private var question: String
    private var answer1: String
    private var answer2 : String
    private var answer3: String
    private var answer4: String
    private var correctAnswer: String
    
    init(question: String, answer1: String, answer2:String, answer3:String, answer4: String, correctAnswer:String){
        self.question = question
        self.answer1 = answer1;
        self.answer2 = answer2;
        self.answer3 = answer3;
        self.answer4 = answer4;
        self.correctAnswer = correctAnswer;
    }
    
    func getQuestion() -> String{
        return question
    }
    
    func getAnswer1() -> String {
        return answer1
    }
    func getAnswer2() -> String {
        return answer2
    }
    func getAnswer3() -> String {
        return answer3
    }
    func getAnswer4() -> String {
        return answer4
    }
    func getCorrectAnswer() -> String {
        return correctAnswer
    }
}
typealias Questions = [QuestionJson]
