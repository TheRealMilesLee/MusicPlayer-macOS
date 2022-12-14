/**
 * @file RecentView.swift
 * @author Hengyi Li
 * @brief This file is the Recent played music view
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI

struct RecentView: View
{
  @Binding var AccessFile: Array<Playlists>
  @Binding var SliderPlace: Double
  @Binding var selectedSongs: Playlists.ID?
  @Binding var RecentFileURL: Array<String>
  @Binding var playStatusButton : Bool
  @Binding var RecentPlayedArray: Array<Playlists>
  @Binding var searchString: String
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var onSelectedList: Playlists.ID?
  @State private var sortOrder = [KeyPathComparator(\Playlists.Title)]

  var body: some View
  {
    if (searchString == "" || RecentPlayedArray.count == 0)
    {
      Table(RecentPlayedArray, selection: $onSelectedList, sortOrder: $sortOrder)
      {
        TableColumn("Title", value: \.Title)
        TableColumn("Duration", value: \.Duration)
        TableColumn("Artist", value: \.Artist)
        TableColumn("Album", value: \.Album)
      }.onDoubleClick
      {
        if (onSelectedList?.description != nil)
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
      Table(AccessFile.filter {$0.Title.starts(with: searchString)}, selection: $onSelectedList, sortOrder: $sortOrder)
      {
        TableColumn("Title", value: \.Title)
        TableColumn("Duration", value: \.Duration)
        TableColumn("Artist", value: \.Artist)
        TableColumn("Album", value: \.Album)
      }.onDoubleClick
      {
        if (onSelectedList?.description != nil)
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
      if (AccessFile[NameIndex].id == onSelectedList)
      {
        return RecentFileURL[NameIndex]
      }
    }
    return ""
  }
}
