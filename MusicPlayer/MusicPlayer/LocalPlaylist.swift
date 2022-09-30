  //
  //  LocalPlaylist.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 2022/9/27.
  //

import SwiftUI

struct Playlists: Identifiable
{
  let id: Int
  let Title: String
  let Duration: String
  let Artist: String
  let Album: String
}
struct LocalPlaylist: View
{
  @State private var playlists = [
    Playlists(id: 1, Title: "Creep", Duration: "3:59", Artist: "Radiohead", Album: "Pablo Honey"),
    Playlists(id: 2, Title: "Round and Round", Duration: "3:18", Artist: "Imagine Dragons", Album: "Night Visions")
  ]
  var body: some View
  {
    Text("Playlists").padding(.all).font(.headline)
    Table(playlists)
    {
      TableColumn("Number", value: \.id)
      TableColumn("Title", value: \.Title)
      TableColumn("Duration", value: \.Duration)
      TableColumn("Artist", value: \.Artist)
      TableColumn("Album", value: \.Album)
    }
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

struct LocalPlaylist_Previews: PreviewProvider
{
  static var previews: some View
  {
    LocalPlaylist()
  }
}
