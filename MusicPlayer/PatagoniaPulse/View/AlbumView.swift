/**
 * @file AlbumView.swift
 * @author Hengyi Li
 * @brief This file is the Album view
 * @version 1.0
 * @date 2022-12-13
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import SwiftUI

struct AlbumView: View {
  @Binding var accessFile: [Playlists]
  @Binding var currentTableSelection: Playlists.ID?
  @Binding var fileURL: [String]
  @Binding var playStatusButton: Bool
  @Binding var searchString: String
  @Binding var sliderPlace: Double

  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State private var sortOrder = [KeyPathComparator(\Playlists.Album)]

  // 过滤后的数据
  var filteredAccessFile: [Playlists] {
    searchString.isEmpty
    ? accessFile
    : accessFile.filter { $0.Album.starts(with: searchString) }
  }

  var body: some View {
    Table(filteredAccessFile, selection: $currentTableSelection, sortOrder: $sortOrder) {
      TableColumn("Album", value: \.Album)
    }.scrollContentBackground(.hidden)
    .onDoubleClick {
      handleDoubleClick()
    }
    .background(.ultraThinMaterial)
  }

  private func handleDoubleClick() {
    guard currentTableSelection != nil else { return }

    // 安全停止当前播放
    if let player = audioPlayManager.player, player.isPlaying {
      player.stop()
    }

    // 查找歌曲URL
    let result = PatagoniaPulse.FindTitle(
      AccessFile: accessFile,
      selectedSongs: currentTableSelection,
      URLArray: fileURL
    )
    guard !result.isEmpty else { return }

    playStatusButton = true
    sliderPlace = 0
    audioPlayManager.startPlayer(url: result)
  }
}
