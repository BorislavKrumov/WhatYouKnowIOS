//
//  PopupDelegate.swift
//  WhatYouKnow
//
//  Created by Borislav on 5.05.22.
//

import Foundation

protocol PopupDelegate {
    func popupValuePassed(answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: String)
}
