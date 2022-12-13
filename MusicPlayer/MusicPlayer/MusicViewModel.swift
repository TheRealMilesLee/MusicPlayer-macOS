/**
 * @file MusicViewModel.swift
 * @author Hengyi Li
 * @brief This file is the model to access the playlists struct
 * @version 1.0
 * @date 2022-12-12
 * @copyright Copyright (c) 2022. Hengyi Li, All rights reserved
 */
import Foundation
import AppKit

final class MusicViewModel: ObservableObject
{
  private(set) var MusicPlayerApp: Playlists
  init(MusicPlayerApp: Playlists)
  {
    self.MusicPlayerApp = MusicPlayerApp
  }
}

struct Playlists: Identifiable
{
  let id = UUID()
  let Title: String
  let Duration: String
  let Artist: String
  let Album: String
  let image: NSImage?
  static let data = Playlists(Title:"", Duration: "", Artist: "", Album: "", image: NSImage())
}
