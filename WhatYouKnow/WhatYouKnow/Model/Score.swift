//
//  Score.swift
//  WhatYouKnow
//
//  Created by Borislav on 30.04.22.
//

import Foundation

struct Score {
    private var score : Int
    
    init(score :Int){
        self.score = score
    }
    
    func getScore() -> Int{
        return score
    }

}

