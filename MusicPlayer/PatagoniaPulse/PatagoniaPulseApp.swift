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
  @Environment(\.controlActiveState) private var controlActiveState

  var body: some Scene
  {
    WindowGroup
    {
      ContentView(MusicViewModel: PatagoniaPulseApp.MusicVM)
        .environmentObject(AudioPlayManager())
        .onChange(of: controlActiveState) { oldValue, newValue in
          switch newValue
          {
            case .key, .active:
              break
            case .inactive:
              NSApplication.shared.terminate(nil)
            @unknown default:
              fatalError("Error, cannnot close")
          }
        }
    }
  }
}
