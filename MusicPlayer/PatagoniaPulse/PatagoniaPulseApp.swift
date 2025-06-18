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
  @State private var reloadID = UUID()

  var body: some Scene
  {
    WindowGroup
    {
      ContentView(MusicViewModel: PatagoniaPulseApp.MusicVM)
        .environmentObject(AudioPlayManager())
//        .id(reloadID)
    }
    .commands {
      CommandMenu("File") {
        Button("Choose Music Folder…") {
          if let url = showOpenPanel() {
            user_folder = url
            reloadID = UUID()
          }
        }
        .keyboardShortcut("O", modifiers: [.command])
      }
    }
  }
}
