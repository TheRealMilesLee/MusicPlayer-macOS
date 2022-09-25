/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
import MusicKit

struct ContentView: View
{
  @State private var SliderInitialplace = 0.0
  var body: some View
  {
    VStack {
      NavigationView
      {
        VStack
        {
          List
          {
            NavigationLink(destination: Feed()
              .frame(width: 10.0, height: 10.0)){Label("Feed", systemImage: "dot.radiowaves.left.and.right")}
            NavigationLink(destination: Library()){Label("Library", systemImage: "square.grid.2x2.fill")}
          }
        }
        VStack
        {
          Feed()
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
          
          Button(action: {})
          {
            Image(systemName: "play.fill").font(.title3)
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

struct Feed: View
{
  var body: some View
  {
    Text("Feed").font(.headline).fontWeight(.semibold)
    let file_list = read_file_from_disk()
    Section (header: Text("Pick for you"), footer: Text("End"))
    {
      Text("Today's list")
    }
    
  }
}


struct Library: View
{
  var body: some View
  {
    Text("Browse").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
  }
}

struct Artists: View
{
  var body: some View
  {
    Text("Artists").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
  }
}

struct Songs: View
{
  var body: some View
  {
    Text("Songs").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
    
  }
}

struct Album: View
{
  var body: some View
  {
    Text("Album").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
  }
}

struct contentview_preview: PreviewProvider
{
  static var previews: some View
  {
    ContentView()
  }
}

func read_file_from_disk() -> Array<String>
{
  return ["H", "E", "L", "L", "O"]
}
