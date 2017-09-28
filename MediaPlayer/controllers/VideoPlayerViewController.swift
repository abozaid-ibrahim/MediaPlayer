//
//  VideoPlayerViewController.swift
//  MediaPlayer
//
//  Created by abuzeid on 9/28/17.
//  Copyright © 2017 aone. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

final class VideoPlayerViewController: AVPlayerViewController,AVPlayerViewControllerDelegate{
    
    
    @IBOutlet weak var customControllsView: UIView!
    
    final let data = ["smile","watch","video"]
    
    //final var player: AVPlayer? = AVPlayer()
    //    final var playerLayer: AVPlayerLayer?
    final var current  = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        
        
        if let path = Bundle.main.path(forResource: data[current], ofType: "mp4"){
            let videoURL = NSURL(fileURLWithPath: path)
            initPlayer(url:videoURL as URL)
        }
        
        initPlayerView()
        
        
    }
    func initPlayerView(){
        self.showsPlaybackControls = false
        self.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue

 
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        current = -1
        nextVideo()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        customControllsView.frame = self.view.frame
         self.view.addSubview(customControllsView)
        self.view.bringSubview(toFront: customControllsView)
        // Layout subviews manually
        //        playerLayer?.frame = view.bounds
    }
    
    
    
    
    

    
    
    func initPlayer(url:URL) {
        
        player = AVPlayer(url:url)
        
        
        //        playerLayer = AVPlayerLayer(player: player)
        //        view.layer.insertSublayer(playerLayer!, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        nextVideo()
    }
    func nUrl()->URL?{
        
        if let path = Bundle.main.path(forResource: data[current], ofType: "mp4"){
            return NSURL(fileURLWithPath: path) as URL
        }
        
        return nil
    }
    
    
    
    
    func nextVideo(){
        if current ==  data.count - 1{
            current = -1
        }
        current += 1
        guard let url = nUrl() else {
            print("PATH NOT FOUND...")
            return;
        }
        play(url: url)
    
    }
    func prevVideo(){
        if current == 0 {
            current = data.count
        }
        current -= 1
        guard let url = nUrl() else {
            print("PATH NOT FOUND...")
            return;
        }
        play(url: url)
        
    }
    func play(url:URL){
        let playerItem = AVPlayerItem(url:url)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
        
    }
    
    func resume(){
        player?.play()
        
    }
    func pause(){
        player?.pause()
        
    }
    
    
    @IBAction func playPauseAction(_ sender: Any) {
        if ((self.player?.rate != 0) && (self.player?.error == nil)) {
            self.pause()
        }else{
            self.resume()
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        nextVideo()
    }
    
    @IBAction func previousAction(_ sender: Any) {
        self.prevVideo()
    }
    
}
