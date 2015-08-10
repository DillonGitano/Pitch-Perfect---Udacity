//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dillon Gitano on 7/24/15.
//  Copyright (c) 2015 Dillon Gitano. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if var snailPlay = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!){
//
//        }else {
//            println("the filePath is empty")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //I'd love to write a function and simplify these two buttons but I'm not yet that creative with Swift syntax, soon though!
    
    @IBAction func snailPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
}

    @IBAction func rabbitPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func chipmunkPlayback(sender: UIButton) {
        playAudioWithVariablePitch(1200)
        audioPlayer.rate = 1.5
    }
    
    @IBAction func darthPlayback(sender: UIButton) {
        playAudioWithVariablePitch(-1200)
        audioPlayer.rate = 0.5
    }
   
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
