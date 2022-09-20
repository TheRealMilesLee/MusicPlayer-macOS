/**
 * This file is the main page for the window
 */
import SwiftUI
import Foundation
import WebKit

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
          NavigationLink(destination: MyLibrary()){Text("Library").padding(.all).font(.system(size: 12, weight: .light, design: .serif))}
          NavigationLink(destination: Artists()){Text("Artists").padding(.all).font(.system(size: 12, weight: .light, design: .serif))}
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
    VStack{
      Text ("Welcome").font(.system(size: 24, weight: .light, design: .serif)).multilineTextAlignment(.center).padding(.all)
      Text("begin your journey by make a new connection or select a exisitig connection from the history").padding(.all).multilineTextAlignment(.center)
        .font(.system(size: 12, weight: .light, design: .serif))
    }.navigationTitle("Home Page")
  }
}

struct MyLibrary: View
{
  var body: some View
  {
    Text("Blas")
  }
}

struct Artists: View
{
  var body: some View
  {
    Text ("History connection here") .navigationTitle("History Connection")
  }
}

struct Songs: View
{
  var body: some View
  {
    Text("File Manager").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
  }
}

struct Album: View
{
  var body: some View
  {
    Text("Bla")
  }
}
