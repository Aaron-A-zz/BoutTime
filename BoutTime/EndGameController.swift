//
//  EndGameController.swift
//  BoutTime
//
//  Created by Aaron on 5/6/16.
//  Copyright © 2016 Aaron A. All rights reserved.
//

import UIKit

class EndGameController: UIViewController {

    @IBOutlet weak var gameScoreLabel: UILabel!
    
    var endGameScore: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        gameScoreLabel.text = endGameScore
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
