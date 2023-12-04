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
    var tasks: [Task<Void, Error>] = []

    for indexArray in getMusicPath
    {
        let task = Task
        {
            do
            {
                let asset = AVPlayerItem(url: URL(fileURLWithPath: indexArray))
                let metadataList = try await asset.asset.load(.metadata)
                var metaAlbum: String = "No AlbumName"
                var metaArtist: String = "No Artist name"
                var metaArtworkData: NSData?

                for item in metadataList
                {
                    if let key = item.commonKey, let value = try await item.load(.value)
                    {
                        switch key.rawValue
                        {
                            case "albumName":
                                metaAlbum = value as? String ?? "No AlbumName"
                            case "artist":
                                metaArtist = value as? String ?? "No Artist name"
                            case "artwork":
                                metaArtworkData = value as? NSData
                            default:
                                break
                        }
                    }
                }

                let durationAsset = AVURLAsset(url: URL(fileURLWithPath: indexArray), options: nil)
                let songDuration = try await durationAsset.load(.duration)

                // Update UI or store data (using concurrent-safe storage mechanisms) with the obtained metadata
                updateMetadata(album: metaAlbum, artist: metaArtist, artworkData: metaArtworkData, duration: songDuration)

            } catch {
                print(error)
            }
        }

        tasks.append(task)
    }

    do {
        // Wait for all tasks to complete
        try await Task.withGroup(resultType: Void.self) { group in
            for task in tasks
            {
                await group.add { try await task.value() }
            }
        }
    } catch {
        print(error)
    }
}

// Function to handle the obtained metadata (You can modify it based on your use-case)
func updateMetadata(album: String, artist: String, artworkData: NSData?, duration: CMTime)
{
    metaAlbumArray.append(album)
    metaArtistArray.append(artist)
    metaArtwork.append(artworkData)
    metaDuration.append(duration)
}

/**
 * @brief This function is to get the file name from the folder that user specified
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
