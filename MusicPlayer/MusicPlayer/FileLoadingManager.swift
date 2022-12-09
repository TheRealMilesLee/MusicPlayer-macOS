import Foundation
import SwiftUI
import MusicKit
import AVFoundation
import AVKit
var audioPlayer: AVAudioPlayer!
let user_folder = showOpenPanel()

func getFileNameArray() -> Array<String>
{
  let FileHandler_user = FileManager.default
  var MusicFileArray: [String] = []
  do
  {
    let contents = try FileHandler_user.contentsOfDirectory(atPath: user_folder!.path)
    for iteration in 0..<contents.count
    {
      if (contents[iteration] == ".DS_Store")
      {
        continue
      }
      MusicFileArray.append(contents[iteration])
    }
  } catch {
    print("File read error at \(error)")
  }
  return MusicFileArray
}

func MusicPlayFileArray() -> Array<String>
{
  let FileName = getFileNameArray()
  var MusicFileWithPath: [String] = []
  for filePath in 0..<FileName.count
  {
    let ConcateneteResult = (user_folder?.path())! + FileName[filePath]
    MusicFileWithPath.append(ConcateneteResult)
    print(MusicFileWithPath[filePath])
  }
  return MusicFileWithPath
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
