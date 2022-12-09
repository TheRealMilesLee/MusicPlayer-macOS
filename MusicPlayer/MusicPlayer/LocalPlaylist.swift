
import SwiftUI
import AVKit
import AVFAudio
import AVFoundation
struct LocalPlaylist: View
{
  @State var load_file : Bool = false
  @State private var selectedSongs = Set<Playlists.ID>()
  @State private var AccessFile: Array<Playlists> = Array()
  var body: some View
  {
    VStack
    {
      Text("Playlists").padding(.all).font(.headline)
      Button("Load from File", action:{
        let contents = getFileNameArray()
        let PlaylistArray = MusicPlayFileArray()
        for content in 0..<contents.count
        {
            AccessFile.append(Playlists(Title: contents[content], Duration: "3:59",  Artist: "testArtist", Album: "TestAlbum", image: "Bah"))
        }
      })
      Table(AccessFile, selection: $selectedSongs)
      {
        TableColumn("Title", value: \.Title)
        TableColumn("Duration", value: \.Duration)
        TableColumn("Artist", value: \.Artist)
        TableColumn("Album", value: \.Album)
      }
      Text("\(selectedSongs.description) is selected")
    }
  }
}



