//
//  GameOverViewController.swift
//  WhatYouKnow
//
//  Created by Borislav on 29.04.22.
//

import UIKit

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newGame() {
        let newGame = NewGameViewController()
        newGame.modalPresentationStyle = .overFullScreen
        present(newGame, animated: true)
    }
    @IBAction func homeScreen() {
        let homeScreen = ViewController()
        homeScreen.modalPresentationStyle = .overFullScreen
        present(homeScreen, animated: true)
        
    }
}
