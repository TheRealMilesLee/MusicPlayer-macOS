
import SwiftUI
import AVKit
import AVFAudio
import AVFoundation
struct LocalPlaylist: View
{
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
    }

  }
  func FindTitle(AccessFile: [Playlists]) -> String
  {
    for NameIndex in AccessFile
    {
      if (NameIndex.id == selectedSongs)
      {
        return NameIndex.Title
      }
    }
    return "Null"
  }
}


//if (selectedSongs?.description != nil)
//{
//  let Result = FindTitle(AccessFile: AccessFile)
//  Text(Result)
//}


