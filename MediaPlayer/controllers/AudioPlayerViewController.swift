//
//  AudioPlayerViewController.swift
//  MediaPlayer
//
//  Created by abuzeid on 9/28/17.
//  Copyright © 2017 aone. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class AudioPlayerViewController: UIViewController,  AVAudioPlayerDelegate
{
    var audioPlayer: AVAudioPlayer? = AVAudioPlayer()
    
    var playAudioRepeatedly: Bool = false
    
    let arrAudio: [String] = ["chime_bell_ding", "music_marimba_chord", "pop_drip"]
    
    @IBOutlet var btnPlayAudioRepeatedly: UIButton!
    @IBOutlet var btnStopAudio: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //    MARK: - AVAudioPlayerDelegate Methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        if (playAudioRepeatedly)
        {
            audioPlayer!.play()
        }
    }
  
    
    //    MARK: - Action Methods
    
    @IBAction func btnPlayAudioTapped(sender: AnyObject)
    {
        playAudio()
    }
  
    @IBAction func btnPlayAudioRepeatedlyTapped(sender: AnyObject)
    {
        btnPlayAudioRepeatedly.isEnabled = false
        btnStopAudio.isEnabled = true
        playAudioRepeatedly = true
        playAudio()
    }
    
    @IBAction func btnStopAudioTapped(sender: AnyObject)
    {
        stopAudio()
    }
    
    
    //    MARK: - Other Methods
    
    func playAudio()
    {
        // get random number for sound from the array
        let intRandomNum = Int(arc4random_uniform(UInt32(arrAudio.count)))
        
        // set URL of the sound
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: arrAudio[intRandomNum], ofType: "wav")!)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)
            audioPlayer!.delegate = self
            
            // check if audioPlayer is prepared to play audio
            if (audioPlayer!.prepareToPlay())
            {
                audioPlayer!.play()
            }
        }
        catch
        { }
    }
    
    func stopAudio()
    {
        guard audioPlayer != nil else {
            return
        }
        audioPlayer!.stop()
        btnPlayAudioRepeatedly.isEnabled = true
        btnStopAudio.isEnabled = false
        playAudioRepeatedly = false
    }
    
}
