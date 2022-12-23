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
  @Binding var CurrentTableSelection: Playlists.ID?
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
          CurrentTableSelection = onSelectedList
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = readInRecentFileURL(RecentArray: AccessFile, selectedRecentSongs: CurrentTableSelection)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
          RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
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
          CurrentTableSelection = onSelectedList
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = readInRecentFileURL(RecentArray: RecentPlayedArray, selectedRecentSongs: CurrentTableSelection)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
          RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
        }
      }
    }
  }
  
  func RecentPlayed(AccessFile: [Playlists], selectedSongs: Playlists.ID?, RecentPlayedArray: inout [Playlists])
  {
    if (selectedSongs?.description != nil)
    {
      if (RecentPlayedArray.count > 0)
      {
          //        If found in the Recent Array, swap it with index 0
        var AppendIndex: Int = 0
        var StopFlag: Bool = false
        while (!StopFlag && AppendIndex < RecentPlayedArray.count)
        {
          if (RecentPlayedArray[AppendIndex].id == selectedSongs)
          {
            RecentPlayedArray.swapAt(AppendIndex, 0)
            StopFlag = true
          }
          AppendIndex += 1
        }
          //        If it does not found in Recent Array, append it
        if (!StopFlag)
        {
          var AppendIndexAccess: Int = 0
          var AppendFinished: Bool = false
          while (!AppendFinished && AppendIndexAccess < AccessFile.count)
          {
            if (AccessFile[AppendIndexAccess].id == selectedSongs)
            {
              RecentPlayedArray.append(AccessFile[AppendIndexAccess])
              AppendFinished = true
            }
            AppendIndexAccess += 1
          }
        }
      }
        //    First Element insert
      else
      {
        var AppendIndexAppend: Int = 0
        var StopFlagAppend: Bool = false
        while (!StopFlagAppend)
        {
          if (selectedSongs == AccessFile[AppendIndexAppend].id)
          {
            RecentPlayedArray.append(AccessFile[AppendIndexAppend])
            StopFlagAppend = true
          }
          AppendIndexAppend += 1
        }
      }
    }
  }

}
