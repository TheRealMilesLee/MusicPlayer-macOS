  //
  //  AudioPlayManager.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 2022/12/3.
  //

import Foundation
import AVKit

final class AudioPlayManager: ObservableObject
{
  var player: AVAudioPlayer?
  var AudioAsset: AVAsset?
  
  func startPlayer(url: String)
  {
    do
    {
      player =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
      player?.prepareToPlay()
      player?.play()
    } catch
    {
      print("Error info: \(error)")
    }
  }

  func playPause()
  {
    guard let PlayPauseButton = player else
    {
      print ("No audio player found")
      return
    }
    if(PlayPauseButton.isPlaying)
    {
      PlayPauseButton.pause()
    }
    else
    {
      PlayPauseButton.play()
    }
  }

  func Stop()
  {
    guard let stopButton = player else
    {
      print ("No audio player found")
      return
    }
    stopButton.stop()
  }
}
