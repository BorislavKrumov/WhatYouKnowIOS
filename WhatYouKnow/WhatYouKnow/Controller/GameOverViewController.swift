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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newGame() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewGame", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewGameViewController") as! NewGameViewController
        self.present(nextViewController, animated:true, completion:nil)

    }
    @IBAction func homeScreen() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
}
