//
//  UsefulFunctions.swift
//  MusicPlayer
//
//  Created by Silverhand on 2022/12/2.
//

import Foundation
import SwiftUI
import MusicKit
import AVFoundation
var audioPlayer:AVAudioPlayer!

func getFileNameArray() -> Array<String>
{
  let FileHandler_user = FileManager.default
  let user_folder = showOpenPanel()
  do
  {
    var contents = try FileHandler_user.contentsOfDirectory(atPath: user_folder!.path)
    contents.append(user_folder!.path)
    return contents
  } catch {
    print("File read error at \(error)")
  }
  return ["Error at reading"]
}

func showOpenPanel() -> URL?
{
  let openPanel = NSOpenPanel()
  openPanel.allowsMultipleSelection = true
  openPanel.canChooseDirectories = true
  openPanel.canChooseFiles = true
  let response = openPanel.runModal()
  let FileHandler_user = FileManager.default
  let FileURL = FileHandler_user.urls(for: .musicDirectory, in: .userDomainMask)
  let defaultURL = FileURL[0] as URL
  if (response == .OK)
  {
    return openPanel.url
  }
  else
  {
    return defaultURL
  }
}
