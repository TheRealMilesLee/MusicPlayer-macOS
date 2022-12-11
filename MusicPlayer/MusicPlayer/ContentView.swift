/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
struct ContentView: View
{
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @StateObject var MusicViewModel: MusicViewModel
  @State var selectedSongs: Playlists.ID?
  @State var AccessFile: Array<Playlists> = Array()
  @State var SliderPlace: Double = 0.0
  @State var PickClick = false
  @State var playStatusButton : Bool = false
  @State var FileNameContents = getFileNameArray()
  @State var FileURL = MusicPlayFileArray()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var body: some View
  {
    VStack
    {
      NavigationView
      {
        VStack
        {
          List
          {
            Text("Library").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination:
                            LocalPlaylist(
                              FileNameContents:$FileNameContents ,
                              FileURL: $FileURL,
                              SliderPlace: $SliderPlace,
                              playStatusButton: $playStatusButton,
                              selectedSongs: $selectedSongs,
                              AccessFile: $AccessFile
                            )){Label("Local Playlist", systemImage: "music.note.list")}
            NavigationLink(destination: Artist()){Label("Artist", systemImage: "person.crop.square")}
            NavigationLink(destination: Album()){Label("Album", systemImage: "rectangle.stack.fill")}
          }.padding(.bottom)
        }
      }
      Divider()
        // Play Display Section
      HStack
      {
          // This is the Album image, song title and the slide bar
        HStack
        {
          Image(nsImage: #imageLiteral(resourceName: "Primo.jpg"))
            .resizable()
            .frame(width: 60, height: 60)
            .shadow(radius: 6, x: 0, y: 3)
            .padding(.leading, 10).padding(.bottom, 10)
          Text(MusicViewModel.MusicPlayerApp.Title).padding(.leading, 10)
          if let SliderAudioplayer = audioPlayManager.player
          {
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
            Backward()
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
          })
          {
            Image(systemName: "forward.fill").font(.title3)
          }.buttonStyle(PlainButtonStyle()).padding(.trailing, 15)

          // Stop Button, only arrear if is playing
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
  func Backward()
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
          print(IndexBackward)
          selectedSongs = AccessFile[IndexBackward - 1].id
          print(IndexBackward - 1)
          playStatusButton = true
          SliderPlace = 0
          audioPlayManager.startPlayer(url: FileURL[IndexBackward - 1])
          break
        }
      }
    }
  }
}

struct contentview_preview: PreviewProvider
{
  static let MusicVM = MusicViewModel(MusicPlayerApp: Playlists.data)
  static var previews: some View
  {
    ContentView(MusicViewModel: MusicVM)
      .environmentObject(AudioPlayManager())
  }
}
