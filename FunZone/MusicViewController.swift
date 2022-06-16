//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 6/2/22.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    @IBOutlet weak var musicTimer: UILabel!
    @IBOutlet weak var musicProgress: UIProgressView!
    var audioPlayer: AVAudioPlayer?
    var musicFile: String?
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.path(forResource: musicFile, ofType: "mp3")
        let newUrl = URL(fileURLWithPath: filePath!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: newUrl)
        }
        catch {
            print("file not found")
        }
        
    }

    // This is for the Music tab
    @IBAction func startMusic(_ sender: Any) {
        musicFile = "zapsplat"
        audioPlayer?.play()
        musicTimer.text = audioPlayer?.currentTime.description
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        print("music is playing")
    }
    
    var myTime: Float = 0.0
    @IBAction func stopMusic(_ sender: Any) {
        audioPlayer?.stop()
        timer?.invalidate()
        musicProgress.setProgress(0.0, animated: true)
        myTime = 0.0
        musicTimer.text = String(format: "%.2f", myTime)
        print("music has stopped")
    }
    
    @objc func updateTime() {
        musicTimer.text = String(format: "%.2f", myTime)
        myTime = myTime + 0.01
        musicProgress.setProgress(myTime, animated: true)
    }
    
}
