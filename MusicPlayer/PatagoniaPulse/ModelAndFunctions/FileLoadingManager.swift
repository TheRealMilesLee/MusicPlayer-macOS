/**
 * @file FileLoadingManager.swift
 * @author Hengyi Li
 * @brief This file is the controller for the File load in
 * @version 1.1
 * @date 2025-06-17
 * @copyright Copyright (c) 2025. Hengyi Li, All rights reserved
 */
import AVKit
import AppKit
import SwiftUI

var audioPlayer: AVAudioPlayer!

// 改为可选类型，不立即初始化
var user_folder: URL? = nil

/// @brief This function is to pop up a window for user to choose the folder location
/// @return URL
func showOpenPanel() -> URL? {
  let openPanel = NSOpenPanel()
  openPanel.allowsMultipleSelection = false  // 改为 false，因为你只需要一个文件夹
  openPanel.canChooseDirectories = true
  openPanel.canChooseFiles = false  // 改为 false，因为你只需要选择文件夹
  openPanel.message = "请选择音乐文件夹"  // 添加提示信息

  let response = openPanel.runModal()
  if response == .OK {
    return openPanel.url
  } else {
    return nil  // 返回 nil 而不是退出程序
  }
}

/// @brief 初始化用户文件夹选择，应该在应用启动后调用
func initializeUserFolder() {
  if user_folder == nil {
    user_folder = showOpenPanel()
  }
}

/// @brief This function loads the metadata for a single song file.
/// @param fileURL URL of the audio file
/// @return A tuple containing album name, artist name, optional artwork, and duration of the song
/// @throws Rethrows any errors encountered during metadata loading
func loadSongMetadata(for fileURL: URL) async throws -> (
  album: String, artist: String, artwork: NSData?, duration: CMTime
) {
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

/// @brief This function is to get the file name from the folder that user specified. Only file names are loaded initially.
/// @return Array<String>
func getFileNameArray() -> [String] {
  // 确保用户文件夹已选择
  guard let userFolder = user_folder else {
    print("用户文件夹未选择")
    return []
  }

  let fileManager = FileManager.default
  do {
    let contents = try fileManager.contentsOfDirectory(atPath: userFolder.path)
    let musicFileArray = contents.filter { $0 != ".DS_Store" }
    return musicFileArray
  } catch {
    print("File read error: \(error)")
    return []
  }
}

/// @brief This function is to get the file name from the folder that user specified with the path of the folder
/// @return Array<String>
func MusicPlayFileArray() -> [String] {
  // 确保用户文件夹已选择
  guard let userFolder = user_folder else {
    print("用户文件夹未选择")
    return []
  }

  let FileName = getFileNameArray()
  var MusicFileWithPath: [String] = []
  for filePath in 0..<FileName.count {
    let ConcatenateResult = userFolder.path + "/" + FileName[filePath]  // 添加路径分隔符
    MusicFileWithPath.append(ConcatenateResult)
  }
  return MusicFileWithPath
}

/// @brief This function is to find the title in corresponding path array
/// @return String
func FindTitle(AccessFile: [Playlists], selectedSongs: Playlists.ID?, URLArray: [String]) -> String
{
  for NameIndex in 0..<AccessFile.count {
    if AccessFile[NameIndex].id == selectedSongs {
      return URLArray[NameIndex]
    }
  }
  return ""
}

func readInRecentFileURL(RecentArray: [Playlists], selectedRecentSongs: Playlists.ID?) -> String {
  let RecentURL = MusicPlayFileArray()
  for NameIndex in 0..<RecentArray.count {
    if RecentArray[NameIndex].id == selectedRecentSongs {
      return RecentURL[NameIndex]
    }
  }
  return ""
}
