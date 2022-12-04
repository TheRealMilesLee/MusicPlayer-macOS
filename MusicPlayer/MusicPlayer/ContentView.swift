/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
struct ContentView: View
{
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @StateObject var MusicViewModel: MusicViewModel
  @State private var SliderPlace: Double = 0.0
  @State var PickClick = false
  @State var playStatusButton : Bool = false
  let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
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
            NavigationLink(destination: LocalPlaylist()){Label("Local Playlist", systemImage: "music.note.list")}
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
            Image("Cover").resizable().frame(width: 25, height: 25).shadow(radius: 6, x: 0, y: 3).padding(.all)
            Text(MusicViewModel.MusicPlayerApp.Title).padding(.leading, 10)
            if let SliderAudioplayer = audioPlayManager.player
            {
              HStack
              {
                Text(SliderAudioplayer.currentTime.formatted())
                Slider(value: $SliderPlace,in: 0...SliderAudioplayer.duration)
                {
                  editing in
                  print(editing)
                  if !editing
                  {
                    SliderAudioplayer.currentTime = SliderPlace
                  }
                }
                Spacer()
                Text(String(SliderAudioplayer.duration - SliderAudioplayer.currentTime))
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

          Button {
            playStatusButton = true
            audioPlayManager.startPlayer(Title: "Primo")
            SliderPlace = 0
          } label: {
            Text("Start the player")
          }

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

          Button {
            let StopButton = audioPlayManager.player
            playStatusButton = false
            audioPlayManager.Stop()
            SliderPlace = 0
            StopButton!.currentTime = 0

          } label: {
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
