/**
 * @file FileLoadingManager.swift
 * @author Hengyi Li
 * @brief This file is the controller for the File load in
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import Foundation
import SwiftUI
import MusicKit
import AVFoundation
import AVKit
import MediaPlayer
import AppKit

var audioPlayer: AVAudioPlayer!
let user_folder = showOpenPanel()
var metaAlbumArray:[String] = []
var metaArtistArray:[String] = []
var metaArtwork:[NSData] = []
var metaDuration: [CMTime] = []

/**
 * @brief This function is to get the MP3 asset
 * @return void
 */
func GetAsset() async
{
  let getMusicPath = MusicPlayFileArray()
  for indexArray in getMusicPath
  {
    let asset = AVPlayerItem(url: URL(fileURLWithPath: indexArray))
    do
    {
      let metadataList = try await asset.asset.load(.metadata)
      for item in metadataList
      {
        if let key = item.commonKey, let value = try await item.load(.value)
        {
          if (key.rawValue == "albumName")
          {
            metaAlbumArray.append(((value as? String) ?? "No AlbumName"))
          }
          if (key.rawValue == "artist")
          {
            metaArtistArray.append(((value as? String) ?? "No Artist name"))
          }
          if (key.rawValue == "artwork")
          {
            metaArtwork.append(value as! NSData)
          }
        }
      }
      let DurationAsset = AVURLAsset(url: URL(fileURLWithPath: indexArray), options: nil)
      let SongDuration = try await DurationAsset.load(.duration)
      metaDuration.append(SongDuration)
    }catch
    {
      print(error)
    }
  }
}

/**
 * @brief This function is to get the file name from the folder that user specified
 * @return Array<String>
 */
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
  }
  catch
  {
    print("File read error at \(error)")
  }
  return MusicFileArray
}

/**
 * @brief This function is to get the file name from the folder that user specified with the path of the folder
 * @return Array<String>
 */
func MusicPlayFileArray() -> Array<String>
{
  let FileName = getFileNameArray()
  var MusicFileWithPath: [String] = []
  for filePath in 0..<FileName.count
  {
    let ConcateneteResult = (user_folder?.path())! + FileName[filePath]
    MusicFileWithPath.append(ConcateneteResult)
  }
  return MusicFileWithPath
}

/**
 * @brief This function is to pop up a window for user to choose the folder location
 * @return URL
 */
func showOpenPanel() -> URL?
{
  let openPanel = NSOpenPanel()
  openPanel.allowsMultipleSelection = true
  openPanel.canChooseDirectories = true
  openPanel.canChooseFiles = true
  let response = openPanel.runModal()
  if (response == .OK)
  {
    return openPanel.url
  }
  else
  {
    exit(EXIT_SUCCESS)
  }
}

/**
 * @brief This function is to find the title in corresponding path array
 * @return String
 */
func FindTitle(AccessFile: [Playlists], selectedSongs: Playlists.ID?, URLArray: [String]) -> String
{
  for NameIndex in 0..<AccessFile.count
  {
    if (AccessFile[NameIndex].id == selectedSongs)
    {
      return URLArray[NameIndex]
    }
  }
  return ""
}

func readInRecentFileURL(RecentArray: [Playlists], selectedRecentSongs: Playlists.ID?) ->String
{
  let RecentURL = MusicPlayFileArray()

  for NameIndex in 0..<RecentArray.count
  {
    if (RecentArray[NameIndex].id == selectedRecentSongs)
    {
      return RecentURL[NameIndex]
    }
  }
  return ""
}
