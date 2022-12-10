/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
struct ContentView: View
{
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @StateObject var MusicViewModel: MusicViewModel
  @State var SliderPlace: Double = 0.0
  @State var PickClick = false
  @State var playStatusButton : Bool = false
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
            NavigationLink(destination: LocalPlaylist(SliderPlace: $SliderPlace, playStatusButton: $playStatusButton)){Label("Local Playlist", systemImage: "music.note.list")}
            NavigationLink(destination: Artist()){Label("Artist", systemImage: "person.crop.square")}
            NavigationLink(destination: Album()){Label("Album", systemImage: "rectangle.stack.fill")}
          }.padding(.bottom)
        }
      }
      Divider()
      HStack
      {
        Button(action: {})
        {
          HStack
          {
            Image(MusicViewModel.MusicPlayerApp.image).resizable().frame(width: 25, height: 25).shadow(radius: 6, x: 0, y: 3).padding(.all)
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
        }.buttonStyle(PlainButtonStyle())
        Spacer()
        HStack
        {
          Button(action: {})
          {
            Image(systemName: "backward.fill").font(.title3)
          }.buttonStyle(PlainButtonStyle()).padding(.leading, 30)

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

          Button(action: {})
          {
            Image(systemName: "forward.fill").font(.title3)
          }.buttonStyle(PlainButtonStyle()).padding(.trailing, 30)

          Button
          {
            let StopButton = audioPlayManager.player
            playStatusButton = false
            audioPlayManager.Stop()
            SliderPlace = 0
            StopButton!.currentTime = 0
          } label:
          {
            Image(systemName: "stop.fill").font(.title3)
          }
        }.buttonStyle(PlainButtonStyle()) .onReceive(timer) { _ in
          guard let playerStatus = audioPlayManager.player else {return}
          SliderPlace = playerStatus.currentTime
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
