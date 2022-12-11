
import SwiftUI
import AVKit
import AVFAudio
import AVFoundation
struct LocalPlaylist: View
{
  @Binding var FileNameContents: Array<String>
  @Binding var FileURL: Array<String>
  @Binding var SliderPlace: Double
  @Binding var playStatusButton : Bool
  @Binding var selectedSongs: Playlists.ID?
  @Binding var AccessFile: Array<Playlists>
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @State var load_file : Bool = false
  @State private var sortOrder = [KeyPathComparator(\Playlists.Title)]
  var body: some View
  {
    Text("Playlists").padding(.all).font(.headline)
    Button("Load from File", action:{
      for content in 0..<FileNameContents.count
      {
        let BeforechoppedFileName = FileNameContents[content]
        let AfterChoppedFileName = BeforechoppedFileName.replacingOccurrences(of: #".mp3"#, with: "").replacingOccurrences(of: #".mp4"#, with: "").replacingOccurrences(of: #".wav"#, with: "").replacingOccurrences(of: #".flac"#, with: "")
        AccessFile.append(Playlists(Title: AfterChoppedFileName, Duration: "3:59",  Artist: "testArtist", Album: "TestAlbum", image: "Bah"))
      }
    })
    Table(AccessFile, selection: $selectedSongs, sortOrder: $sortOrder)
    {
      TableColumn("Title", value: \.Title)
      TableColumn("Duration", value: \.Duration)
      TableColumn("Artist", value: \.Artist)
      TableColumn("Album", value: \.Album)
    }.onDoubleClick {
      if (selectedSongs?.description != nil)
      {
        if ((audioPlayManager.player?.isPlaying) != nil)
        {
          audioPlayManager.player?.stop()
        }
        let Result = FindTitle(AccessFile: AccessFile)
        playStatusButton = true
        SliderPlace = 0
        audioPlayManager.startPlayer(url: Result)
      }
    }
  }
  func FindTitle(AccessFile: [Playlists]) -> String
  {
    for NameIndex in 0..<AccessFile.count
    {
      if (AccessFile[NameIndex].id == selectedSongs)
      {
        return FileURL[NameIndex]
      }
    }
    return "Null"
  }
}
