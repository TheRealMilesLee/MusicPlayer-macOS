/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
import MusicKit

struct ContentView: View
{
  @State private var SliderInitialplace = 0.0
  @State var PickClick = false
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
            NavigationLink(destination: Feed()){Label("Feed", systemImage: "dot.radiowaves.left.and.right")}
            NavigationLink(destination: Library()){Label("Library", systemImage: "square.grid.2x2.fill")}
          }
        }
        Feed()
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


struct Library: View
{
  var body: some View
  {
    Text("Browse").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
  }
}
struct contentview_preview: PreviewProvider
{
  static var previews: some View
  {
    ContentView()
  }
}
