/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
import MusicKit
import AVFoundation
var audioPlayer:AVAudioPlayer!

struct ContentView: View
{
  @State private var SliderInitialplace = 0.0
  @State var PickClick = false
  @State var isPlaying : Bool = false
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
            Text("Feed").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination: PickForYou()){Label("Pick for you", systemImage: "text.line.first.and.arrowtriangle.forward")}
            NavigationLink(destination: Browse()){Label("Browse", systemImage: "square.split.2x2.fill")}
            NavigationLink(destination: PersonalRadio()){Label("Personal Radio", systemImage: "dot.radiowaves.left.and.right")}
            NavigationLink(destination: TodayTop()){Label("Today Top", systemImage: "arrow.up.right.square")}
          }.frame(height: 150.0)
          List
          {
            Text("Library").font(.footnote).foregroundColor(Color.gray).multilineTextAlignment(.leading)
            NavigationLink(destination: LocalPlaylist()){Label("Local Playlist", systemImage: "music.note.list")}
            NavigationLink(destination: Artist()){Label("Artist", systemImage: "person.crop.square")}
            NavigationLink(destination: Album()){Label("Album", systemImage: "rectangle.stack.fill")}
            NavigationLink(destination: Songs()){Label("Songs", systemImage: "music.note")}
            NavigationLink(destination: Connect()){Label("Connect", systemImage: "music.note.tv")}
          }.padding(.bottom)
        }
      }.moveDisabled(false)
      Divider()
      HStack
      {
        Button(action: {})
        {
          HStack
          {
            Image("Cover").resizable().frame(width: 25, height: 25).shadow(radius: 6, x: 0, y: 3).padding(.all)
            Text("Creep").padding(.leading, 10)
            Slider(value: $SliderInitialplace,in: 0...100)
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
            isPlaying.toggle()
            do
            {
              let url = Bundle.main.path(forResource: "Blue", ofType: "mp3")
              audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
              let player = audioPlayer
              if (isPlaying)
              {
                player?.prepareToPlay()
                player?.play()
              }
              else
              {
                player?.pause()
              }
            } catch
            {
              print("Error info: \(error)")
            }
          })
          {
            if (!isPlaying)
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
        }.buttonStyle(PlainButtonStyle())
      }
    }
  }
}

struct contentview_preview: PreviewProvider
{
  static var previews: some View
  {
    ContentView()
  }
}
