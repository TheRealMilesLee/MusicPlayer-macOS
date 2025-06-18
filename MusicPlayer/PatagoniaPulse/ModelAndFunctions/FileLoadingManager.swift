/**
 * @file FileLoadingManager.swift
 * @author Hengyi Li
 * @brief This file is the controller for the File load in
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */

import SwiftUI
//import MusicKit
import AVKit
import AppKit

var audioPlayer: AVAudioPlayer!
let user_folder = showOpenPanel()

/**
 * @brief This function loads the metadata for a single song file.
 * @param fileURL URL of the audio file
 * @return A tuple containing album name, artist name, optional artwork, and duration of the song
 * @throws Rethrows any errors encountered during metadata loading
 */
func loadSongMetadata(for fileURL: URL) async throws -> (album: String, artist: String, artwork: NSData?, duration: CMTime) {
    let asset = AVPlayerItem(url: fileURL)
    var albumName = "No AlbumName"
    var artistName = "No Artist name"
    var artworkData: NSData? = nil
    do {
        let metadataList = try await asset.asset.load(.metadata)
        for item in metadataList {
            if let key = item.commonKey, let value = try await item.load(.value) {
                if key.rawValue == "albumName" {
                    albumName = (value as? String) ?? albumName
                }
                if key.rawValue == "artist" {
                    artistName = (value as? String) ?? artistName
                }
                if key.rawValue == "artwork" {
                    artworkData = value as? NSData
                }
            }
        }
        let durationAsset = AVURLAsset(url: fileURL, options: nil)
        let songDuration = try await durationAsset.load(.duration)
        return (albumName, artistName, artworkData, songDuration)
    } catch {
        throw error
    }
}

/**
 * @brief This function is to get the file name from the folder that user specified. Only file names are loaded initially.
 * @return Array<String>
 */
func getFileNameArray() -> [String]
{
  let fileManager = FileManager.default
  do
  {
    let contents = try fileManager.contentsOfDirectory(atPath: user_folder!.path)
    let musicFileArray = contents.filter { $0 != ".DS_Store" }
    return musicFileArray
  } catch {
    print("File read error: \(error)")
    return []
  }
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
    let ConcatenateResult = (user_folder?.path())! + FileName[filePath]
    MusicFileWithPath.append(ConcatenateResult)
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
