
import SwiftUI
import AVKit
import AVFAudio
import AVFoundation
struct LocalPlaylist: View
{
  @EnvironmentObject var audioPlayManager: AudioPlayManager
  @Binding var SliderPlace: Double
  @Binding var playStatusButton : Bool
  @State var load_file : Bool = false
  @State private var selectedSongs: Playlists.ID?
  @State private var AccessFile: Array<Playlists> = Array()
  @State private var sortOrder = [KeyPathComparator(\Playlists.Title)]

  var body: some View
  {
    Text("Playlists").padding(.all).font(.headline)
    Button("Load from File", action:{
      let contents = getFileNameArray()
      for content in 0..<contents.count
      {
        AccessFile.append(Playlists(Title: contents[content], Duration: "3:59",  Artist: "testArtist", Album: "TestAlbum", image: "Bah"))
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
    let FileURL = MusicPlayFileArray()
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
