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
    @IBOutlet weak var shakeLabel: UILabel!
    @IBOutlet weak var currentRoundLabel: UILabel!
    
    var soundEffect: AVAudioPlayer!
    var gameScore = 0
    var roundCounter = 1
    var countDown = 60
    var timer: NSTimer?
    var gameEvents : [HistoricalEvent] = []
    var currentRound : [HistoricalEvent] = []
    var nextGame: [HistoricalEvent] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        //Kicks of the Alert then calls on dismissAlert which starts the game :) 
        showAlert("Place the Presidents in the order in which they served. The oldest at the top & the most recent at the bottom.")
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
            
            svg.endGameScore = "\(gameScore)/6"
        }
    }

    // Get 24 random questions from the presidentsList Array located in the HistoricalEvent.swift file
    func startGame() {
        
        shuffle()
        for i in 0...23 {
            gameEvents.append(nextGame[i])
        }
        startRound()
    }
    
    func startRound() {
        // Starts a new round by selecting the first four questions from gameEvents
          currentRoundLabel.text = "Round: \(roundCounter)"
        if roundCounter == 7 {
            endGame()
            return
        }
        
        //Setting timer
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
        //resets the timer to 60 after each round.
        countDown = 60
        countDownLabel.text = "0:\(countDown)"
    }
    
    func startTimer() {
        //Kick off timer
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
    
    //Takes the users answer then shorts it. If the user answer matches the sorted answer, the user is awarded one point for each round.
    func checkAnswer(Useranswer: [HistoricalEvent]) {
        
        timer!.invalidate()
        resetCounterLabel()
        roundCounter += 1
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
        
        nextGame = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(presidentsList) as! [HistoricalEvent]
    
    }
    
        //Remove the last 4 items from the current array that way we are never repeating the events
    func endRound() {
        
        gameEvents.removeRange(0...3)
        
    }
    
    //Displays nextRoundButton
    func showNextRoundButton() {
        
        nextRoundButton.hidden = false
        shakeLabel.hidden = true
    }
    
    // Kicks off the next round after the user taps the button
    @IBAction func nextRoundButtonPressed(sender: AnyObject) {

        nextRoundButton.hidden = true
        shakeLabel.hidden = false
        clearCurrentRound()
        startRound()
    }
    
        //Clear the current round array after which you will need to call startRound() to add the next events for the following round.
    func clearCurrentRound() {
        
        currentRound.removeAll()
    }
    
        //Calls check answer when user shakes the device
    func userShakesiPhone(){
        
        checkAnswer(currentRound)
    }
    
    //Plays soundEffects for correct or wrong answers by taking a string as a paramater we can pass in the sound we need.
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
        currentRoundLabel.text = "Round: \(roundCounter)"
        self.performSegueWithIdentifier("gameOver", sender: self)
    }
    
    // Alert is displayed at the begining of each round to notify the user of how to play the game.
    func showAlert(title: String, message: String? = nil, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: dismissAlert)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //Dismisses the alert.
    func dismissAlert(sender: UIAlertAction) {
        startGame()
    }


}

