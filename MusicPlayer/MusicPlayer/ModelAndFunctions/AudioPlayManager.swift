/**
 * @file AudioPlayManager.swift
 * @author Hengyi Li
 * @brief This file is the controller for the audio playback
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import Foundation
import AVKit

final class AudioPlayManager: ObservableObject
{
  var player: AVAudioPlayer?
  var AudioAsset: AVAsset?

// Creating a new audio player instance and playing the audio file.
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

// Checking if the player is playing or not. If it is playing, it pauses the player. If it is not
// playing, it plays the player.
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

// This function stops the player.
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
