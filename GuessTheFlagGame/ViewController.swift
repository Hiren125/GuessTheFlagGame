//
//  ViewController.swift
//  GuessTheFlagGame
//
//  Created by Hiren on 21/06/20.
//  Copyright © 2020 Hiren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var titles:String?
    var countries:[String] = []
    var scoreCount = 0
    var correctAnswer = 0
    var totalQuestionAsked = 0
  
    
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let scoreButton = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showTotalScore))
        self.navigationItem.rightBarButtonItem = scoreButton
        
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        let url1 = URL(string:"https://www.countryflags.io/US/shiny/64.png")!
        let url2 = URL(string:"https://www.countryflags.io/IN/shiny/64.png")!
           let url3 = URL(string:"https://www.countryflags.io/BH/shiny/64.png")!
        getImage(from:url1,count: 1)
        getImage(from:url2,count: 2)
        getImage(from:url3,count: 0)
 
        }

    
    func getImage(from url:URL,count:Int){
         let dataTask = URLSession.shared.dataTask(with: url){
         (data, _, _) in
         
         if let data = data{
             DispatchQueue.main.async {
             
                switch count{
                case 1:
                    self.image1.image = UIImage(data: data)
            
                case 2:
                    self.image2.image = UIImage(data: data)
                            default:
                                self.image3.image = UIImage(data: data)
                        
                }
             }
         }
     }
    dataTask.resume()
        
        
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    
    
    }
    func startNewGame(action: UIAlertAction){
        totalQuestionAsked = 0
        scoreCount = 0
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil){
        
        if(totalQuestionAsked > 10){
         //   totalQuestionAsked = 0
            let qac = UIAlertController(title: "Game Over", message: ", Your Final Score is \(scoreCount)", preferredStyle: .alert)
                   
                 //  print(title)
                   qac.addAction(UIAlertAction(title: "Start new Game!", style: .default, handler: startNewGame))
                   present(qac,animated: true)
     //   scoreCount = 0
        }

        totalQuestionAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        
    ////  button1.setImage(UIImage(named: countries[0]), for: .normal)
   ////     button2.setImage(UIImage(named: countries[1]), for: .normal)
  ////      button3.setImage(UIImage(named: countries[2]), for: .normal)
        
      //  title = countries[correctAnswer].uppercased()
       // title = "Score:\(scoreCount) -- Tap on " + countries[correctAnswer].uppercased() + " 's Flag"
         title = "Tap on " + countries[correctAnswer].uppercased() + " 's Flag"
      //  print(title!)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag == correctAnswer{
            
            titles = "Correct"
            scoreCount += 5
            askQuestion()
        }
        else
        {
            titles = "incorrect"
            scoreCount -= 5
            let wrongAlert = UIAlertController(title: "Wrong", message: "that's flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            
            wrongAlert.addAction(UIAlertAction(title: "Coninue", style: .default, handler: askQuestion))
                present(wrongAlert,animated: true)
        }

    }
    

    @objc func showTotalScore(){
        
        let scoreButtonVC = UIAlertController(title: "Score", message: nil, preferredStyle: .alert)
        
        scoreButtonVC.addAction(UIAlertAction(title: "your Current Score is \(scoreCount)", style: .default, handler: nil))
        present(scoreButtonVC,animated: true)
    }
    
}

