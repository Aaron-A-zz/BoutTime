//
//  ViewController.swift
//  BoutTime
//
//  Created by Aaron on 5/1/16.
//  Copyright © 2016 Aaron A. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var firstEventLable: UILabel!
    @IBOutlet weak var secondEventLable: UILabel!
    @IBOutlet weak var thirdEventLable: UILabel!
    @IBOutlet weak var forthEventLable: UILabel!
    @IBOutlet weak var firstDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var thirdUpButton: UIButton!
    @IBOutlet weak var thirdDownButton: UIButton!
    @IBOutlet weak var forthUpButton: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    
    var soundEffect: AVAudioPlayer!
    var gameScore = 0
    var roundCounter = 0
    var countDown = 60
    var timer: NSTimer?
    var gameEvents : [HistoricalEvent] = []
    var currentRound : [HistoricalEvent] = []
    var nextGame: [HistoricalEvent] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Shake motion code
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            checkAnswer(currentRound)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "gameOver" {
            let svg = segue.destinationViewController as! EndGameController
            
            svg.endGameScore = "\(gameScore)/4"
        }
    }

    // Get 24 random questions from the appleProducts Array located in the HistoricalEvent.swift file
    func startGame() {
        shuffle()
        for i in 0...23 {
            gameEvents.append(nextGame[i])
        }
        
        startRound()
    }
    
    func startRound() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.startTimer), userInfo: nil, repeats: true)
        
        for i in 0...3 {
            currentRound.append(gameEvents[i])
            //set the UITextView to each event
        }
        firstEventLable.text = currentRound[0].description
        secondEventLable.text = currentRound[1].description
        thirdEventLable.text = currentRound[2].description
        forthEventLable.text = currentRound[3].description
    }
    
    func resetCounterLabel(){
        countDown = 60
        countDownLabel.text = "0:\(countDown)"
    }
    
    func startTimer() {
        countDown -= 1
        countDownLabel.text = "0:\(countDown)"
        
        if countDown < 10 {
            countDownLabel.text = "0:0\(countDown)"
        }
        
        if countDown == 0 {
            timer!.invalidate()
            checkAnswer(currentRound)
        }
    }
    
    
    //This checks to see what button was pushed to determine what elements in the array need to be switched and then updates the lables
    @IBAction func upOrDown(sender: AnyObject) {
        switch sender.tag {
        case 1:
            swap(&currentRound[0], &currentRound[1])
        case 2:
            swap(&currentRound[1], &currentRound[0])
        case 3:
            swap(&currentRound[1], &currentRound[2])
        case 4:
            swap(&currentRound[2], &currentRound[1])
        case 5:
            swap(&currentRound[2], &currentRound[3])
        case 6:
            swap(&currentRound[3], &currentRound[2])
        default:
            print("defualt")
        }
        updateEventLables()
    }
    
    //Check users answer by comparing the users answer to the users sorted answer
    func checkAnswer(Useranswer: [HistoricalEvent]) {
        timer!.invalidate()
        resetCounterLabel()
        roundCounter += 1
        
        if roundCounter == 6 {
            endGame()
            return
        }
        
        //sort users answer. In short we are putting all the events in order
        let answer = Useranswer.sort{$0.date < $1.date}
        
        if currentRound == answer {
            // Add 1 point for given round
            gameScore += 1
            nextRoundButton.setImage(UIImage(named: "next_round_success.png"), forState: UIControlState.Normal)
            playSound("CorrectDing.wav")
        } else {
            // Let the user know they are wrong! Wrong! WRONG!
            playSound("IncorrectBuzz.wav")
            nextRoundButton.setImage(UIImage(named: "next_round_fail.png"), forState: UIControlState.Normal)
        }
        countDown = 60
        endRound()
        showNextRoundButton()
        print(gameScore)
    }
        //Updates label text
    func updateEventLables() {
        firstEventLable.text = currentRound[0].description
        secondEventLable.text = currentRound[1].description
        thirdEventLable.text = currentRound[2].description
        forthEventLable.text = currentRound[3].description
    }
    
        //Shuffles the array so that each game is distinctive
    func shuffle() {
        nextGame = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(appleProducts) as! [HistoricalEvent]
    }
    
        //Remove the last 4 items from the current array
    func endRound() {
        gameEvents.removeRange(0...3)
        
    }
    
    
    func showNextRoundButton() {
        nextRoundButton.hidden = false
    }
    
    @IBAction func nextRoundButtonPressed(sender: AnyObject) {
        nextRoundButton.hidden = true
        clearCurrentRound()
        startRound()
        
    }
    
        //Clear the current round array after which you will need to call startRound() to add the next events for the following round.
    func clearCurrentRound() {
        currentRound.removeAll()
    }
    
        //When the user shakes the iPhone we want to check the answer
    func userShakesiPhone(){
        checkAnswer(currentRound)
    }
    
    func playSound(file: String) {
        let path = NSBundle.mainBundle().pathForResource(file, ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            soundEffect = sound
            sound.play()
        } catch {
            print("File not found")
        }
    }
    
        // Game over! display user score
    func endGame() {
        roundCounter = 0
        self.performSegueWithIdentifier("gameOver", sender: self)
    }

}

