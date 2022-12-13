  //
  //  iCloudDrive.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 2022/12/12.
  //

import SwiftUI

struct iCloudDrive: View
{
  @Binding var AccessFile: Array<Playlists>
  @Binding var SliderPlace: Double
  @Binding var RecentFileURL: Array<String>
  @Binding var playStatusButton : Bool
  @State var onSelectedList: Playlists.ID?
  @State private var sortOrder = [KeyPathComparator(\Playlists.Title)]
  @EnvironmentObject var audioPlayManager: AudioPlayManager

  var body: some View
  {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}
