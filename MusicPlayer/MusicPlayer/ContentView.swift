/**
 * @file ContentView.swift
 * @author Hengyi Li
 * @brief This file is the main UI interface for the MusicPlayerApp
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI
import Foundation
import AppKit
import AVKit
import AVFoundation
import Cocoa
struct ContentView: View
{
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @StateObject var MusicViewModel: MusicViewModel
  @State var selectedSongs: Playlists.ID?
  @State var RecentFileURL: Array<String> = Array()
  @State var AccessFile: Array<Playlists> = Array()
  @State var SliderPlace: Double = 0.0
  @State var PickClick = false
  @State var playStatusButton : Bool = false
  @State var FileNameContents = getFileNameArray()
  @State var FileURL = MusicPlayFileArray()
  @State var RecentPlayedArray: Array<Playlists> = Array()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var body: some View
  {
    VStack
    {
      NavigationView
      {
          //      Sidebar Navigation
        VStack
        {
          List
          {
            Text("Playlists").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination:
                            LocalPlaylistView(
                              FileNameContents:$FileNameContents ,
                              FileURL: $FileURL,
                              SliderPlace: $SliderPlace,
                              playStatusButton: $playStatusButton,
                              selectedSongs: $selectedSongs,
                              AccessFile: $AccessFile,
                              RecentPlayedArray: $RecentPlayedArray
                            )){Label("Local Playlist", systemImage: "music.note.list")}
            NavigationLink(destination:RecentView( AccessFile:$AccessFile,
                                                   SliderPlace: $SliderPlace,
                                                   selectedSongs: $selectedSongs,
                                                   RecentFileURL: $RecentFileURL,
                                                   playStatusButton: $playStatusButton,
                                                   RecentPlayedArray: $RecentPlayedArray)){Label("Recent", systemImage: "tray.full")}
            NavigationLink(destination: FindMusic()){Label("Find Music", systemImage:"shazam.logo")}
            Spacer()
            Text("Categories").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination: ArtistView( FileURL:$FileURL ,
                                                    SliderPlace: $SliderPlace ,
                                                    playStatusButton: $playStatusButton,
                                                    selectedSongs: $selectedSongs,
                                                    AccessFile: $AccessFile )){Label("Artist", systemImage: "person.crop.rectangle.stack")}
            NavigationLink(destination: AlbumView(FileURL:$FileURL ,
                                                  SliderPlace: $SliderPlace ,
                                                  playStatusButton: $playStatusButton,
                                                  selectedSongs: $selectedSongs,
                                                  AccessFile: $AccessFile)){Label("Album", systemImage: "play.square.stack")}
          }.padding(.bottom).onAppear(perform: {
              //            Load file and asset from the disk
            Task
            {
              await GetAsset()
              for content in 0..<FileNameContents.count
              {
                let BeforechoppedFileName = FileNameContents[content]
                let AfterChoppedFileName = BeforechoppedFileName.replacingOccurrences(of: #".mp3"#, with: "").replacingOccurrences(of: #".mp4"#, with: "").replacingOccurrences(of: #".wav"#, with: "").replacingOccurrences(of: #".flac"#, with: "")
                let DurationTimeSeconds = CMTimeGetSeconds(metaDuration[content])
                let DurationToMinutes = DurationTimeSeconds / 60
                let DurationRoundMinutes = Double(round(100 * DurationToMinutes) / 100)
                let DurationStringnify = String(DurationRoundMinutes).replacingOccurrences(of: #"."#, with: ":")
                let AlbumImage = NSImage(data: metaArtwork[content] as Data)
                AccessFile.append(Playlists(Title: AfterChoppedFileName, Duration: DurationStringnify,  Artist: metaArtistArray[content], Album: metaAlbumArray[content], image: AlbumImage))
              }
            }
          })
        }
      }
      Divider()
        // Play Display Section
      HStack
      {
          // This is the Album image, song title and the slide bar
        AlbumImageDisplay(AccessFile: AccessFile, selectedSongs: selectedSongs)
          .resizable()
          .frame(width: 60, height: 60)
          .shadow(radius: 6, x: 0, y: 3)
          .padding(.leading, 10).padding(.bottom, 10)
        HStack
        {
          if let SliderAudioplayer = audioPlayManager.player
          {
            if ((audioPlayManager.player?.isPlaying) != nil)
            {
              Text(getPlayingSongName(AccessFile: AccessFile, selectedSongs: selectedSongs)).padding(.leading, 10)
            }
            HStack
            {
              let CurrentToMinutes = Double(SliderAudioplayer.currentTime.formatted())! / 60
              let CurrentRoundMinutes = Double(round(100 * CurrentToMinutes) / 100)
              let CurrentStringnify = String(CurrentRoundMinutes).replacingOccurrences(of: #"."#, with: ":")
              Text(CurrentStringnify)
              Slider(value: $SliderPlace,in: 0...SliderAudioplayer.duration)
              {
                Slide in
                if (!Slide)
                {
                  SliderAudioplayer.currentTime = SliderPlace
                }
              }
              Spacer()
              let ToMinutes = (SliderAudioplayer.duration - SliderAudioplayer.currentTime) / 60
              let RoundMinutes = Double(round(100 * ToMinutes) / 100)
              let Stringnify = String(RoundMinutes).replacingOccurrences(of: #"."#, with: ":")
              Text(Stringnify)
            }
          }
        }
        Spacer()

          // Here is the button for Backward, forward and Play/Pause
        HStack
        {
            // Backward button
          Button(action: {
            Backward(AccessFile: AccessFile)
            RecentPlayed(AccessFile: AccessFile, selectedSongs: selectedSongs, RecentPlayedArray:&RecentPlayedArray)
          })
          {
            Image(systemName: "backward.fill").font(.title3)
          }.buttonStyle(PlainButtonStyle()).padding(.leading, 30)

            // Play/Pause button
          Button(action:{
            playStatusButton.toggle()
            audioPlayManager.playPause()
          })
          {
            if (!playStatusButton)
            {
              Image(systemName: "play.fill").font(.title3)
            }
            else
            {
              Image(systemName: "pause.fill").font(.title3)
            }
          }.buttonStyle(PlainButtonStyle()).padding(.horizontal)

            // Forward button
          Button(action: {
            Forward(AccessFile: AccessFile)
            RecentPlayed(AccessFile: AccessFile, selectedSongs: selectedSongs, RecentPlayedArray:&RecentPlayedArray)
          })
          {
            Image(systemName: "forward.fill").font(.title3)
          }.buttonStyle(PlainButtonStyle()).padding(.trailing, 15)

            // Stop Button, only appear if is playing
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            Button
            {
              playStatusButton = false
              audioPlayManager.Stop()
              SliderPlace = 0
              audioPlayManager.player!.currentTime = 0
            } label:
            {
              Image(systemName: "stop.fill").font(.title3)
            }.buttonStyle(PlainButtonStyle()).padding(.trailing, 30)
          }
        }.buttonStyle(PlainButtonStyle())
          // The Slider updater
          .onReceive(timer)
        {  _ in
          guard let playerStatus = audioPlayManager.player else {return}
          SliderPlace = playerStatus.currentTime
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

  /**
   * @brief This function is to control the audio forward
   * @param AccessFile is a Array of Playlists
   */
  func Forward(AccessFile: [Playlists])
  {
    for IndexForward in 0..<AccessFile.count
    {
      if (AccessFile[IndexForward].id == selectedSongs)
      {
        if (IndexForward == AccessFile.count)
        {
          audioPlayManager.Stop()
          playStatusButton = false
          SliderPlace = 0
          audioPlayManager.player?.currentTime = 0
          break
        }
        else
        {
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.Stop()
            playStatusButton = false
            SliderPlace = 0
            audioPlayManager.player?.currentTime = 0
          }
          let newIndex = IndexForward + 1
          if (newIndex == AccessFile.count)
          {
            audioPlayManager.Stop()
            playStatusButton = false
            SliderPlace = 0
            audioPlayManager.player?.currentTime = 0
            break
          }
          selectedSongs = AccessFile[newIndex].id
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: FileURL[newIndex])
          break
        }
      }
    }
  }

  /**
   * @brief This function is to control the audio backward
   * @param AccessFile is a Array of Playlists
   */
  func Backward(AccessFile: [Playlists])
  {
    for IndexBackward in 0..<AccessFile.count
    {
      if (AccessFile[IndexBackward].id == selectedSongs)
      {
        if (IndexBackward == 0)
        {
          audioPlayManager.Stop()
          playStatusButton = false
          SliderPlace = 0
          audioPlayManager.player?.currentTime = 0
          break
        }
        else
        {
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.Stop()
            playStatusButton = false
            SliderPlace = 0
            audioPlayManager.player?.currentTime = 0
          }
          selectedSongs = AccessFile[IndexBackward - 1].id
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: FileURL[IndexBackward - 1])
          break
        }
      }
    }
  }
}

func getPlayingSongName(AccessFile: [Playlists], selectedSongs: Playlists.ID?) -> String
{
  for SongNameIndex in 0..<AccessFile.count
  {
    if (AccessFile[SongNameIndex].id == selectedSongs)
    {
      return AccessFile[SongNameIndex].Title
    }
  }
  return ""
}

func AlbumImageDisplay(AccessFile: [Playlists], selectedSongs: Playlists.ID?) -> Image
{
  for AlbumImageIndex in 0..<AccessFile.count
  {
    if (AccessFile[AlbumImageIndex].id == selectedSongs)
    {
      return Image(nsImage: AccessFile[AlbumImageIndex].image!)
    }
  }
  return Image("")
}
