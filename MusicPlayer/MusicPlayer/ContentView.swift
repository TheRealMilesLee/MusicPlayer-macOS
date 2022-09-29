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
          Label("Feed", systemImage: "wifi.circle.fill")
          List
          {
            NavigationLink(destination: PickForYou()){Label("Pick for you", systemImage: "text.line.first.and.arrowtriangle.forward")}.padding(.bottom)
            NavigationLink(destination: StartListening()){Label("Start Listening", systemImage: "play.square.fill")}.padding(.bottom)
            NavigationLink(destination: PersonalRadio()){Label("Personal Radio", systemImage: "dot.radiowaves.left.and.right")}.padding(.bottom)
          }
          Label("Library", systemImage: "airport.extreme")
          List
          {
            NavigationLink(destination: Library()){Label("Local Playlist", systemImage: "text.insert")}.padding(.bottom)
            NavigationLink(destination: Connect()){Label("Connect", systemImage: "music.note.tv")}.padding(.bottom)
          }
        }
      }
    } .navigationTitle("Welcome")
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
            guard let player = audioPlayer else { return }
            if (isPlaying)
            {
              player.prepareToPlay()
              player.play()
            }
            else
            {
              player.pause()
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

struct contentview_preview: PreviewProvider
{
  static var previews: some View
  {
    ContentView()
  }
}
