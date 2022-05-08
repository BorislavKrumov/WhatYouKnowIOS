//
//  AnimationButton.swift
//  WhatYouKnow
//
//  Created by Borislav on 7.05.22.
//

import Foundation
import UIKit

enum AnimationButtonColor {
    case correct
    case wrong
    
    func setCorrectColor(button: UIButton){
        switch self{
        case .correct:
            DispatchQueue.main.async {
                button.backgroundColor = .green
            }
            break
        case .wrong:
            DispatchQueue.main.async {
                button.backgroundColor = .red
            }
            break
        }
        
    }
}




