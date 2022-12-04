//
//  MusicViewModel.swift
//  MusicPlayer
//
//  Created by Silverhand on 2022/12/3.
//

import Foundation

final class MusicViewModel: ObservableObject
{
  private(set) var MusicPlayerApp: Playlists
  init(MusicPlayerApp: Playlists) {
    self.MusicPlayerApp = MusicPlayerApp
  }
}
struct Playlists: Identifiable
{
  let id = UUID()
  let Title: String
  let Duration: String
  let Artist: String
  let Album: String
  let image: String
  static let data = Playlists(Title: "PlaceHolder", Duration: "3:59", Artist: "PlaceHolder", Album: "PlaceHolder", image: "PlaceHolder")
}
