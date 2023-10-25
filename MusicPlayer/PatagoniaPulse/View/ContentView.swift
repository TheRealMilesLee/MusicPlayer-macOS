/**
 * @file ContentView.swift
 * @author Hengyi Li
 * @brief This file is the main UI interface for the PatagoniaPulseApp
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI
import AppKit
import AVKit
struct ContentView: View
{
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @StateObject var MusicViewModel: MusicViewModel
  @State var AccessFile: Array<Playlists> = Array()
  @State var CurrentTableSelection: Playlists.ID?
  @State var FileNameContents = getFileNameArray()
  @State var FileURL = MusicPlayFileArray()
  @State var PickClick = false
  @State var playStatusButton : Bool = false
  @State var repeatStatusButton : Bool = false
  @State var RecentPlayedArray: Array<Playlists> = Array()
  @State var RecentFileURL: Array<String> = Array()
  @State var selectedSongs: Playlists.ID?
  @State var SliderPlace: Double = 0.0
  @State var searchString: String = ""
  @State var randomPlayStatus: Bool = false
  @State var presentPopup = false

  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var body: some View
  {
      //    Layout: Upper Part is the Navigationn Side View and the content of the navigation Bar.Lower part is the music playback controller
    VStack
    {
        //      Navigation bar for the page change in different views
      NavigationView
      {
        VStack
        {
          Spacer()
            //          Search Bar for searching the song by name or by artist, album
          TextField("Search...", text: $searchString)
            .cornerRadius(17)
            .padding([.trailing, .leading])
            .textFieldStyle(.roundedBorder)
            //         Sidebar Navigation
          List
          {
            Text("Playlists").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination: LocalPlaylistView( FileNameContents:$FileNameContents ,
                                                           FileURL: $FileURL,
                                                           SliderPlace: $SliderPlace,
                                                           playStatusButton: $playStatusButton,
                                                           selectedSongs: $selectedSongs,
                                                           AccessFile: $AccessFile,
                                                           RecentPlayedArray: $RecentPlayedArray,
                                                           searchString: $searchString,
                                                           CurrentTableSelection: $CurrentTableSelection,
                                                           randomPlayStatus: $randomPlayStatus
                                                         )) {Label("Local Playlist", systemImage: "music.note.list")}
            NavigationLink(destination:RecentView( AccessFile:$AccessFile,
                                                   SliderPlace: $SliderPlace,
                                                   selectedSongs: $selectedSongs,
                                                   RecentFileURL: $RecentFileURL,
                                                   playStatusButton: $playStatusButton,
                                                   RecentPlayedArray: $RecentPlayedArray,
                                                   searchString: $searchString,
                                                   CurrentTableSelection: $CurrentTableSelection
                                                 )){Label("Recent", systemImage: "tray.full")}
            Spacer()
            Text("Categories").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination: ArtistView( FileURL:$FileURL ,
                                                    SliderPlace: $SliderPlace ,
                                                    playStatusButton: $playStatusButton,
                                                    AccessFile: $AccessFile,
                                                    searchString: $searchString,
                                                    CurrentTableSelection: $CurrentTableSelection
                                                  )){Label("Artist", systemImage: "person.and.background.dotted")}
            NavigationLink(destination: AlbumView( AccessFile: $AccessFile,
                                                   CurrentTableSelection: $CurrentTableSelection,
                                                   FileURL:$FileURL ,
                                                   playStatusButton: $playStatusButton,
                                                   searchString: $searchString,
                                                   SliderPlace: $SliderPlace
                                                 )){Label("Album", systemImage: "play.square.stack")}
          }
          .padding(.bottom)
            //             Load file and asset from the disk
          .onAppear(perform: {Task { await selectFolderAndProcess()}})

        }
        Spacer()
          //       Music Playback controller, only appear if is currently playing
        if(CurrentTableSelection != nil)
        {
          HStack
          {
            if let SliderAudioplayer = audioPlayManager.player
            {
                //             This is the Album image, song title and the slide bar
              AlbumImageDisplay(AccessFile: AccessFile, selectedSongs: CurrentTableSelection)
                .resizable()
                .frame(width: 70.0, height: 70.0)
                .shadow(radius: 6, x: 0, y: 3)
                .padding([.top, .leading, .bottom])
                .multilineTextAlignment(.leading)
                //          Slider control, drag and drop and the current play time
              VStack
              {
                  //              Playback time control
                HStack(alignment: .center)
                {
                    //                Current Time
                  Text(CurrentTimeFormatting(SliderAudioPlayer: SliderAudioplayer))
                    //                Slider
                  Slider(value: $SliderPlace,in: 0...SliderAudioplayer.duration)
                  {
                    Slide in
                    if (!Slide)
                    {
                      SliderAudioplayer.currentTime = SliderPlace
                    }

                  }.onChange(of: SliderPlace, perform: { newValue in
                    let currentTime = CurrentTimeFormatting(SliderAudioPlayer: SliderAudioplayer)
                    let duration = DurationTimeFormatting(SliderAudioPlayer: SliderAudioplayer)
                    if (currentTime == duration)
                    {
                      if (repeatStatusButton)
                      {
                        randomPlayStatus = false
                        repeatPlay(AccessFile: AccessFile, SliderAudioplayer: SliderAudioplayer, FileURL: FileURL, repeatStatusButton: repeatStatusButton, currentTime: currentTime, duration: duration)
                      }
                      else if (randomPlayStatus)
                      {
                        repeatStatusButton = false
                        randomPlay(AccessFile: AccessFile, SliderAudioplayer: SliderAudioplayer, FileURL: FileURL, randomPlayStatus: randomPlayStatus)
                        CurrentTableSelection = selectedSongs
                        RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
                      }
                      else
                      {
                        repeatStatusButton = false
                        randomPlayStatus = false
                        Forward(AccessFile: AccessFile)
                        CurrentTableSelection = selectedSongs
                        RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
                      }
                    }
                  })
                  .padding(.horizontal)
                  Spacer()
                    //                Remain time
                  Text(LeftTimeFormatting(SliderAudioPlayer: SliderAudioplayer))
                }.padding(.horizontal, 150).multilineTextAlignment(.center)
                  //             Here is the button for Backward, forward and Play/Pause
                HStack
                {
                  Button
                  {
                    randomPlayStatus = false
                    repeatStatusButton.toggle()
                  } label:
                  {
                    if (repeatStatusButton)
                    {
                      Image(systemName: "infinity.circle.fill").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    else
                    {
                      Image(systemName: "infinity.circle").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                  }

                    // Backward button
                  Button(action: {
                    Backward(AccessFile: AccessFile)
                    CurrentTableSelection = selectedSongs
                    RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray: &RecentPlayedArray)
                  })
                  {
                    Image(systemName: "backward.fill").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                  }.buttonStyle(PlainButtonStyle())

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
                  }.buttonStyle(PlainButtonStyle()).padding([.leading, .bottom, .trailing]).multilineTextAlignment(.center)

                    // Forward button
                  Button(action: {
                    Forward(AccessFile: AccessFile)
                    CurrentTableSelection = selectedSongs
                    RecentPlayed(AccessFile: AccessFile, selectedSongs: CurrentTableSelection, RecentPlayedArray:&RecentPlayedArray)
                  })
                  {
                    Image(systemName: "forward.fill").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                  }.buttonStyle(PlainButtonStyle())

                    // Stop Button, only appear if is playing
                  if ((audioPlayManager.player?.isPlaying) != nil)
                  {
                    Button
                    {
                      playStatusButton = false
                      audioPlayManager.Stop()
                      let player = audioPlayManager
                      SliderPlace = 0
                      player.player?.currentTime = 0
                    } label:
                    {
                      Image(systemName: "stop.fill").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.buttonStyle(PlainButtonStyle())
                  }

                  Button
                  {
                    randomPlayStatus.toggle()
                    repeatStatusButton = false
                  } label: {
                    if (randomPlayStatus)
                    {
                      Image(systemName: "shuffle.circle.fill").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    else
                    {
                      Image(systemName: "shuffle.circle").font(.title3).padding([.leading, .bottom, .trailing]).multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                  }

                }.buttonStyle(PlainButtonStyle()).padding(.top, 10)
                  //             The Slider updater
                  .onReceive(timer)
                {  _ in
                  guard let playerStatus = audioPlayManager.player else {return}
                  SliderPlace = playerStatus.currentTime

                }
                  //              Current playing song name display
                if ((audioPlayManager.player?.isPlaying) != nil)
                {
                  Text(getPlayingSongName(AccessFile: AccessFile, selectedSongs: CurrentTableSelection)).padding([.leading, .bottom, .trailing])
                }
              }
            }
          }
        }
      }
    }
  }

  /*---------------------------------------------------- Read in empty handling -------------------------------------------------------------------*/
  /**
   * @brief This function is to handling when the user selected folder does not have any music files
   * @return void
   */
  func selectFolderAndProcess() async
  {
    let getmetaDuration = metaDuration
    if (getmetaDuration.isEmpty)
    {
      let alert = NSAlert()
      alert.messageText = "Error"
      alert.informativeText = "The folder you choose does not have any music."
      alert.alertStyle = .critical
      alert.addButton(withTitle: "Quit")
      let response = alert.runModal()
      if (response == .alertFirstButtonReturn)
      {
        NSApp.terminate(nil)
      }
    }
    for content in 0..<FileNameContents.count
    {
      let BeforechoppedFileName = FileNameContents[content]
      let AfterChoppedFileName = BeforechoppedFileName
        .replacingOccurrences(of: #".mp3"#, with: "")
        .replacingOccurrences(of: #".mp4"#, with: "")
        .replacingOccurrences(of: #".wav"#, with: "")
        .replacingOccurrences(of: #".flac"#, with: "")
        // Check if metaDuration is empty
      let DurationTimeSeconds = CMTimeGetSeconds(metaDuration[content])
      let DurationToMinutes = DurationTimeSeconds / 60
      let DurationRoundMinutes = Double(round(100 * DurationToMinutes) / 100)
      let DurationStringnify = String(DurationRoundMinutes).replacingOccurrences(of: #"."#, with: ":")
      let AlbumImage = NSImage(data: metaArtwork[content] as Data)
      AccessFile.append(Playlists(Title: AfterChoppedFileName, Duration: DurationStringnify,  Artist: metaArtistArray[content], Album: metaAlbumArray[content], image: AlbumImage))
    }
  }


  /*---------------------------------------------------- Playback Function -------------------------------------------------------------------*/
  /**
   * @brief This function is to control the audio forward
   * @param AccessFile is a Array of Playlists to forward
   * @return void
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
          audioPlayManager.player?.currentTime = 0
          break
        }
        else
        {
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.Stop()
            playStatusButton = false
            audioPlayManager.player?.currentTime = 0
          }
          let newIndex = IndexForward + 1
          if (newIndex == AccessFile.count)
          {
            audioPlayManager.Stop()
            playStatusButton = false
            audioPlayManager.player?.currentTime = 0
            break
          }
          else
          {
            selectedSongs = AccessFile[newIndex].id
            playStatusButton = true
            audioPlayManager.startPlayer(url: FileURL[newIndex])
            break
          }
        }
      }
    }
  }

  /**
   * @brief This function is to control the audio backward
   * @param AccessFile is a Array of Playlists to backward
   * @return void
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
          audioPlayManager.player?.currentTime = 0
          break
        }
        else
        {
          if ((audioPlayManager.player?.isPlaying) != nil)
          {
            audioPlayManager.Stop()
            playStatusButton = false
            audioPlayManager.player?.currentTime = 0
          }
          selectedSongs = AccessFile[IndexBackward - 1].id
          playStatusButton = true
          audioPlayManager.startPlayer(url: FileURL[IndexBackward - 1])
          break
        }
      }
    }
  }

  /**
   * @brief This function is to control the audio repeat
   * @param AccessFile is a Array of Playlists to repeat
   * @return void
   */
  func repeatPlay(AccessFile: [Playlists], SliderAudioplayer: AVAudioPlayer, FileURL: [String], repeatStatusButton: Bool, currentTime: String, duration: String)
  {
    playStatusButton = false
    audioPlayManager.Stop()
    for indexPlaylist in 0..<FileURL.count
    {
      if (AccessFile[indexPlaylist].id == CurrentTableSelection)
      {
        playStatusButton = true
        audioPlayManager.startPlayer(url: FileURL[indexPlaylist])
        break
      }
    }

  }

  func randomPlay(AccessFile:[Playlists], SliderAudioplayer: AVAudioPlayer, FileURL: [String], randomPlayStatus: Bool)
  {
    let randomIndex = Int.random(in: 0..<AccessFile.count)
    playStatusButton = false
    audioPlayManager.Stop()
    selectedSongs = AccessFile[randomIndex].id
    playStatusButton = true
    audioPlayManager.startPlayer(url: FileURL[randomIndex])
  }
}


/*---------------------------------------------- Format Function --------------------------------------------------------------------------*/

/**
 * @brief This function is to formatting the current playing time
 * @param SliderAudioPlayer is the player status
 * @return String is the time stamp in the String format
 */
func CurrentTimeFormatting(SliderAudioPlayer: AVAudioPlayer) -> String
{
  let formatter = DateComponentsFormatter()
  formatter.zeroFormattingBehavior = .pad
  formatter.allowedUnits = [.minute, .second]
  let MinutesFormatter = formatter.string(from: SliderAudioPlayer.currentTime) ?? "0:00"
  return MinutesFormatter
}

/**
 * @brief This function is to formatting the duration time
 * @SliderAudioPlayer is the player status
 * @return String is the time stamp in the String format
 */
func LeftTimeFormatting(SliderAudioPlayer: AVAudioPlayer) -> String
{
  let formatter = DateComponentsFormatter()
  formatter.zeroFormattingBehavior = .pad
  formatter.allowedUnits = [.minute, .second]
  let remainFormatter = formatter.string(from: SliderAudioPlayer.duration - SliderAudioPlayer.currentTime) ?? String(SliderAudioPlayer.duration)
  return remainFormatter
}

/**
 * @brief This function is to formatting the duration time
 * @SliderAudioPlayer is the player status
 * @return String is the time stamp in the String format
 */
func DurationTimeFormatting(SliderAudioPlayer: AVAudioPlayer) -> String
{
  let formatter = DateComponentsFormatter()
  formatter.zeroFormattingBehavior = .pad
  formatter.allowedUnits = [.minute, .second]
  let remainFormatter = formatter.string(from: SliderAudioPlayer.duration - 1) ?? String(SliderAudioPlayer.duration)
  return remainFormatter
}


/*------------------------------------------------------------- History Playlist Function -------------------------------------------------*/
/**
 * @brief This function is to detect what song has been played reciently
 * @param AccessFile is a Array of playlists that contains the name of the song
 * @param selectedSongs is the id of the current selected songs
 * @param RecentPlayedArray is the array that stores the name of the current played songs
 * @return void
 */
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
 * @brief This function is to get the name of the song that is current playing
 * @param AccessFile is an array of Playlist object
 * @param selectedSongs is the id of the songs that is currently selected
 * @return String is the name of the playing song
 */
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

/**
 * @brief This function is to get the image of the current playing song's album
 * @param AccessFile is an array of Playlists object
 * @param selectedSongs is the id of the current playing song
 * @return Image is the cover of the album
 */
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
