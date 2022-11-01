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
  @State var load_file : Bool = false
  var body: some View
  {
    Text("Playlists").padding(.all).font(.headline)
    Table()
    {
      TableColumn("Title", value: "Test tITLE")
      TableColumn("Duration", value: "tEST Duration")
      TableColumn("Artist", value: "Test Artist")
      TableColumn("Album", value: "Test Album")
    }
  }
}

func readFile() -> [Playlists]
{
  var formatted_playlists: [Playlists] = []
  let FileHandler_user = FileManager.default
  let user_folder = showOpenPanel()
  do
  {
    let contents = try FileHandler_user.contentsOfDirectory(atPath: user_folder!.path)
    print(contents)
    var index_iter = 0
    for content in contents
    {
      formatted_playlists.append(Playlists(id:index_iter, Title: content, Duration: "3:59", Artist: "testArtist", Album: "TestAlbum"))
      index_iter += 1
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
