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
  func startPlayer(Title: String)
  {
    guard let url = Bundle.main.path(forResource: Title, ofType: "mp3") else
    {
      print("Problem on looking for file: \(Title)")
      return
    }
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
}
