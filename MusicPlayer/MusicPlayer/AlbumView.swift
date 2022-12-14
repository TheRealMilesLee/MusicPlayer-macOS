/**
 * @file AlbumView.swift
 * @author Hengyi Li
 * @brief This file is the Album view
 * @version 1.0
 * @date 2022-12-13
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI
struct AlbumView: View
{
  @Binding var FileURL: Array<String>
  @Binding var SliderPlace: Double
  @Binding var playStatusButton : Bool
  @Binding var selectedSongs: Playlists.ID?
  @Binding var AccessFile: Array<Playlists>
  @Binding var searchString: String
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var selectedAlbum: Playlists.ID?
  @State var load_file : Bool = false
  @State private var sortOrder = [KeyPathComparator(\Playlists.Album)]

  var body: some View
  {
    if (searchString == "")
    {
      Table(AccessFile, selection: $selectedAlbum, sortOrder: $sortOrder)
      {
        TableColumn("Album", value: \.Album)
      }.onDoubleClick
      {
        if (selectedSongs?.description != nil)
        {
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = FindTitle(AccessFile: AccessFile)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
        }
      }
    }
    else
    {
      Table(AccessFile.filter {$0.Album.starts(with: searchString)}, selection: $selectedAlbum, sortOrder: $sortOrder)
      {
        TableColumn("Album", value: \.Album)
      }.onDoubleClick
      {
        if (selectedSongs?.description != nil)
        {
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = FindTitle(AccessFile: AccessFile)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
        }
      }
    }
  }
  func FindTitle(AccessFile: [Playlists]) -> String
  {
    for NameIndex in 0..<AccessFile.count
    {
      if (AccessFile[NameIndex].id == selectedSongs)
      {
        return FileURL[NameIndex]
      }
    }
    return "Null"
  }
}
