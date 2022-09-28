  //
  //  Library.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 2022/9/27.
  //

import SwiftUI

struct Library: View
{
  @State var loadFromFile = false
  var body: some View
  {
    ZStack
    {
      Text("Browse").padding(.all).position(x: 110, y: 50).font(.system(size: 25, weight: .light, design: .serif))
      Button("Load playlist from file")
      {
        self.loadFromFile.toggle()
      }.padding().offset(x:-200, y: -100)
      if (loadFromFile)
      {
        Text(showOpenPanel()?.absoluteString ?? "")

      }
    }

  }
}

struct Library_Previews: PreviewProvider
{
  static var previews: some View
  {
    Library()
  }
}


func showOpenPanel() -> URL?
{
  let openPanel = NSOpenPanel()
  openPanel.allowsMultipleSelection = true
  openPanel.canChooseDirectories = true
  openPanel.canChooseFiles = true
  let response = openPanel.runModal()

  if (response == .OK)
  {
    return openPanel.url
  }
  else
  {
    return nil
  }
}
