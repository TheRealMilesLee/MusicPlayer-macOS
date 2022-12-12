  //
  //  MusicPlayerApp.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 9/20/22.
  //

import SwiftUI
@main
struct MusicPlayerApp: App
{
  static let MusicVM = MusicViewModel(MusicPlayerApp: Playlists.data)
  var body: some Scene
  {
    WindowGroup
    {
      ContentView(MusicViewModel: MusicPlayerApp.MusicVM)
        .environmentObject(AudioPlayManager())
    }
  }
}
