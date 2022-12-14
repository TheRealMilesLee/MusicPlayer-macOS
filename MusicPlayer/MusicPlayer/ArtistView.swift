/**
 * @file ArtistView.swift
 * @author Hengyi Li
 * @brief This file is the Artist displayed view
 * @version 1.0
 * @date 2022-12-13
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI
struct ArtistView: View
{
  @Binding var FileURL: Array<String>
  @Binding var SliderPlace: Double
  @Binding var playStatusButton : Bool
  @Binding var AccessFile: Array<Playlists>
  @Binding var searchString: String
  @Binding var CurrentTableSelection: Playlists.ID?
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var selectedArtist: Playlists.ID?
  @State var load_file : Bool = false
  @State private var sortOrder = [KeyPathComparator(\Playlists.Artist)]

  var body: some View
  {
    if (searchString == "")
    {
      Table(AccessFile, selection: $selectedArtist, sortOrder: $sortOrder)
      {
        TableColumn("Artist", value: \.Artist)
      }.onDoubleClick
      {
        if (selectedArtist?.description != nil)
        {
          CurrentTableSelection = selectedArtist
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
      Table(AccessFile.filter {$0.Artist.starts(with: searchString)}, selection: $selectedArtist, sortOrder: $sortOrder)
      {
        TableColumn("Artist", value: \.Artist)
      }.onDoubleClick
      {
        if (selectedArtist?.description != nil)
        {
          CurrentTableSelection = selectedArtist
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
      if (AccessFile[NameIndex].id == CurrentTableSelection)
      {
        return FileURL[NameIndex]
      }
    }
    return "Null"
  }
}
