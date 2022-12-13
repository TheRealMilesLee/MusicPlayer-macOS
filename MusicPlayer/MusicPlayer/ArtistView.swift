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
  @Binding var selectedSongs: Playlists.ID?
  @Binding var AccessFile: Array<Playlists>
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var selectedArtist: Playlists.ID?
  @State var load_file : Bool = false
  @State private var sortOrder = [KeyPathComparator(\Playlists.Artist)]

  var body: some View
  {
    Table(AccessFile, selection: $selectedArtist, sortOrder: $sortOrder)
    {
      TableColumn("Artist", value: \.Artist)
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
