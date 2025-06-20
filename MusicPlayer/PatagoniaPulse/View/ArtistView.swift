/**
 * @file ArtistView.swift
 * @author Hengyi Li
 * @brief This file is the Artist displayed view
 * @version 1.0
 * @date 2022-12-13
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI

struct ArtistView: View {
  @Binding var fileURL: [String]
  @Binding var sliderPlace: Double
  @Binding var playStatusButton: Bool
  @Binding var accessFile: [Playlists]
  @Binding var searchString: String
  @Binding var currentTableSelection: Playlists.ID?
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State private var sortOrder = [KeyPathComparator(\Playlists.Artist)]

  // 过滤后数据
  var filteredAccessFile: [Playlists] {
    searchString.isEmpty
    ? accessFile
    : accessFile.filter { $0.Artist.starts(with: searchString) }
  }

  var body: some View {
    Table(filteredAccessFile, selection: $currentTableSelection, sortOrder: $sortOrder) {
      TableColumn("Artist", value: \.Artist)
    }.scrollContentBackground(.hidden)
    .onDoubleClick {
      handleDoubleClick()
    }
    .background(.ultraThinMaterial)
  }

  private func handleDoubleClick() {
    guard let selection = currentTableSelection else { return }

    // 停止当前播放
    if let player = audioPlayManager.player, player.isPlaying {
      player.stop()
    }

    // 查找歌曲URL
    let result = findTitle(for: selection)
    guard !result.isEmpty && result != "Null" else { return }

    playStatusButton = true
    sliderPlace = 0
    audioPlayManager.startPlayer(url: result)
  }

  /// 查找选中歌曲的URL
  private func findTitle(for id: Playlists.ID) -> String {
    if let idx = accessFile.firstIndex(where: { $0.id == id }), idx < fileURL.count {
      return fileURL[idx]
    }
    return "Null"
  }
}
