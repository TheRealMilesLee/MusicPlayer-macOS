import Foundation
import AppKit

struct MusicTrack: Identifiable {
    let id: UUID = UUID()
    let path: String
    let title: String
    let artist: String
    let album: String
    let artworkThumb: NSImage?
    let duration: TimeInterval
}
