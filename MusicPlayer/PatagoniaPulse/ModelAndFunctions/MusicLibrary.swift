import AVFoundation
import AppKit
import Foundation

class MusicLibrary: ObservableObject {
  @Published var tracks: [MusicTrack] = []

  func load(from directory: URL) async {
    // 清空曲库
    tracks.removeAll()
    let fileManager = FileManager.default
    let fileURLs =
      (try? fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)) ?? []
    let musicFiles = fileURLs.filter {
      $0.pathExtension.lowercased() == "mp3" || $0.pathExtension.lowercased() == "flac" /*...*/
    }
    for url in musicFiles {
      let asset = AVAsset(url: url)
      // 只提取必要元数据
      let title = url.deletingPathExtension().lastPathComponent
      var duration: Double = 0
      if let audioTrack = try? await asset.load(.tracks).first(where: { $0.mediaType == .audio }) {
        let timeRange = try? await audioTrack.load(.timeRange)
        duration = timeRange?.duration.seconds ?? 0
      }
      // 可选：异步读取艺术家/专辑/封面
      let track = MusicTrack(
        path: url.path,
        title: title,
        artist: "",  // 可补充读取
        album: "",  // 可补充读取
        artworkThumb: nil,  // 可补充读取
        duration: duration
      )
      tracks.append(track)
    }
  }
}
