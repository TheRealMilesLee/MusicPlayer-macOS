  //
  //  Library.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 2022/9/27.
  //

import SwiftUI

struct Library: View
{
  var body: some View
  {
    List
    {
      Text("My playlists")
      Divider()
      Text("Artists")
      Divider()
      Text("Album")
      Divider()
      Text("Songs")
      Divider()
    }
  }
}

struct Library_Previews: PreviewProvider
{
  static var previews: some View
  {
    Library()
  }
}
