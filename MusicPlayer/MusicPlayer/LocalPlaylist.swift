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
  @State var load_file : Bool = false
  var body: some View
  {
    Text("Playlists").padding(.all).font(.headline)
    Button(action:{
      load_file.toggle()
    })
    {

      if (load_file)
      {
        let content_of_folder = readFile()
        Text(content_of_folder[0])
      }
      else
      {
        Text("load from file")
      }
    }.buttonStyle(PlainButtonStyle()).padding(.horizontal)
    Table(playlists)
    {
      TableColumn("Title", value: \.Title)
      TableColumn("Duration", value: \.Duration)
      TableColumn("Artist", value: \.Artist)
      TableColumn("Album", value: \.Album)
    }
  }
}


func readFile() -> [String]
{
  var formatted_playlists: [String] = []
  let FileHandler_user = FileManager.default
  let user_folder = showOpenPanel()
  do
  {
    let contents = try FileHandler_user.contentsOfDirectory(atPath: user_folder!.path)
    print(contents)
    let index_iter = 0
    for content in contents
    {
      formatted_playlists.append("\(index_iter)"+"\t"+content+"\t"+"3:59"+"\t"+"testArtist"+"\t"+"TestAlbum")
    }
  }
  catch
  {
    print("Problem on reading folder")
  }
  return formatted_playlists
}

func showOpenPanel() -> URL?
{
  let openPanel = NSOpenPanel()
  openPanel.allowsMultipleSelection = true
  openPanel.canChooseDirectories = true
  openPanel.canChooseFiles = true
  let response = openPanel.runModal()
  let FileHandler_user = FileManager.default
  let FileURL = FileHandler_user.urls(for: .musicDirectory, in: .userDomainMask)
  let defaultURL = FileURL[0] as URL
  if (response == .OK)
  {
    return openPanel.url
  }
  else
  {
    return defaultURL
  }
}

struct LocalPlaylist_Previews: PreviewProvider
{
  static var previews: some View
  {
    LocalPlaylist()
  }
}
