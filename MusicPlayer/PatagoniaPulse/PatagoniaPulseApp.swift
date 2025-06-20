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
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene
  {
    WindowGroup
    {
      ContentView(MusicViewModel: PatagoniaPulseApp.MusicVM)
        .environmentObject(AudioPlayManager())
        .id(reloadID)
    }
    .commands {
      CommandMenu("Open") {
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

  class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
      // 等待窗口初始化
      DispatchQueue.main.async {
        if let window = NSApplication.shared.windows.first {
          window.isOpaque = false
          window.backgroundColor = NSColor.clear
          window.titlebarAppearsTransparent = true
          window.titleVisibility = .hidden
          window.styleMask.insert(.fullSizeContentView)
          window.isMovableByWindowBackground = true
          window.hasShadow = true
          // Optional: 使用 vibrancy blur 效果
          let blurView = NSVisualEffectView()
          blurView.blendingMode = .behindWindow
          blurView.material = .hudWindow // 可改成 .sidebar、.menu、.ultraThin 等
          blurView.state = .active
          blurView.frame = window.contentView!.bounds
          blurView.autoresizingMask = [.width, .height]
          window.contentView?.superview?.addSubview(blurView, positioned: .below, relativeTo: nil)
        }
      }
    }
  }

}
