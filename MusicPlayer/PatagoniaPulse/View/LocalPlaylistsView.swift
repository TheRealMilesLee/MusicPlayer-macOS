/**
 * @file LocalPlaylistView.swift
 * @author Hengyi Li
 * @brief This file is the Local playlist view
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI
import AVKit
import AppKit
struct LocalPlaylistView: View
{
  @Binding var FileNameContents: Array<String>
  @Binding var FileURL: Array<String>
  @Binding var SliderPlace: Double
  @Binding var playStatusButton : Bool
  @Binding var selectedSongs: Playlists.ID?
  @Binding var AccessFile: Array<Playlists>
  @Binding var RecentPlayedArray: Array<Playlists>
  @Binding var searchString: String
  @Binding var CurrentTableSelection: Playlists.ID?
  @Binding var randomPlayStatus: Bool
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var load_file : Bool = false
  @State private var sortOrder = [KeyPathComparator(\Playlists.Title)]

  var body: some View
  {
    if (searchString == "")
    {
      Table(AccessFile, selection: $selectedSongs, sortOrder: $sortOrder)
      {
        TableColumn("Title", value: \.Title)
        TableColumn("Duration", value: \.Duration)
        TableColumn("Artist", value: \.Artist)
        TableColumn("Album", value: \.Album)
      }.onDoubleClick
      {
        if (selectedSongs?.description != nil)
        {
          CurrentTableSelection = selectedSongs
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = FindTitle(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, URLArray: FileURL)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
          RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
        }
      }
    }
    else
    {
      Table(AccessFile.filter {$0.Title.starts(with: searchString)}, selection: $selectedSongs, sortOrder: $sortOrder)
      {
        TableColumn("Title", value: \.Title)
        TableColumn("Duration", value: \.Duration)
        TableColumn("Artist", value: \.Artist)
        TableColumn("Album", value: \.Album)
      }.onDoubleClick
      {
        if (selectedSongs?.description != nil)
        {
          CurrentTableSelection = selectedSongs
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.player?.stop()
          }
          let Result = FindTitle(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, URLArray: FileURL)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: Result)
          RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
        }
      }
    }

  }

  func searchResult(AccessFile: [Playlists], searchString: String) ->[Playlists]
  {
    var ResultArray: [Playlists] = []
    var SearchIndex: Int = 0
    var found: Bool = false
    while(!found && SearchIndex < AccessFile.count)
    {
      if (AccessFile[SearchIndex].Title.contains(searchString))
      {
        ResultArray.append(AccessFile[SearchIndex])
        found = true
      }
      else if (AccessFile[SearchIndex].Album.contains(searchString))
      {
        ResultArray.append(AccessFile[SearchIndex])
        found = true
      }
      else if (AccessFile[SearchIndex].Artist.contains(searchString))
      {
        ResultArray.append(AccessFile[SearchIndex])
        found = true
      }
      SearchIndex += 1
    }
    return ResultArray
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
