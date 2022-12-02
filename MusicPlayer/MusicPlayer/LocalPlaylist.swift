
import SwiftUI
struct Playlists: Identifiable
{
  let id: Int
  let Title: String
  let Duration: String
  let Artist: String
  let Album: String
}
struct LocalPlaylist: View
{
  @State var load_file : Bool = false
  @State private var AccessFile: [Playlists] = []
  @State private var selectedSongs = Set<Playlists.ID>()
  var body: some View
  {
    Text("Playlists").padding(.all).font(.headline)
    Button("Load from File", action:{
      let contents = getFileNameArray()
      for content in 0..<contents.count
      {
        AccessFile.append(Playlists(id:content, Title: contents[content], Duration: "3:59", Artist: "testArtist", Album: "TestAlbum"))
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


