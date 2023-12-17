  //
  //  PatagoniaPulseApp.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 9/20/22.
  //

import SwiftUI
@main
struct PatagoniaPulseApp: App
{
  static let MusicVM = MusicViewModel(PatagoniaPulseApp: Playlists.data)


  var body: some Scene
  {
    WindowGroup
    {
      ContentView(MusicViewModel: PatagoniaPulseApp.MusicVM)
        .environmentObject(AudioPlayManager())
        
    }
  }
}
