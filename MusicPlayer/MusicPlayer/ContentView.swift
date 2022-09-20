/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
import MusicKit

struct ContentView: View
{
  var body: some View
  {
    NavigationView
    {
      VStack
      {
        List
        {
          NavigationLink(destination: Feed()){Text("Feed").padding(.all).font(.system(size: 12, weight: .light, design: .serif))}
          NavigationLink(destination: Library()){Text("Library").padding(.all).font(.system(size: 12, weight: .light, design: .serif))}
          
          NavigationLink(destination: Songs()){Text("Songs").padding(.all).font(.system(size: 12, weight: .light, design: .serif))}
          NavigationLink(destination: Album()){Text("Album").padding(.all).font(.system(size: 12, weight: .light, design: .serif))}
        }
      }
      VStack
      {
        Feed()
      }
    } .navigationTitle("Welcome")
  }
}

struct Feed: View
{
  var body: some View
  {
    Text("Feed").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
  }
}

struct Library: View
{
  var body: some View
  {
    Text("Browse").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
    List
    {
      Text("Artists")
      Text("Songs")
      Text("Album")
    }
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
