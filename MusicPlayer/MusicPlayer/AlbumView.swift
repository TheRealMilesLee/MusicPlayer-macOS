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
  @Binding var AccessFile: Array<Playlists>
  @Binding var CurrentTableSelection: Playlists.ID?
  @Binding var FileURL: Array<String>
  @Binding var playStatusButton : Bool
  @Binding var searchString: String
  @Binding var SliderPlace: Double
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var load_file : Bool = false
  @State var selectedAlbum: Playlists.ID?
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
        if (selectedAlbum?.description != nil)
        {
          CurrentTableSelection = selectedAlbum
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = MusicPlayer.FindTitle(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, URLArray: FileURL)
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
        if (selectedAlbum?.description != nil)
        {
          CurrentTableSelection = selectedAlbum
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = MusicPlayer.FindTitle(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, URLArray: FileURL)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
        }
      }
    }
  }
}
