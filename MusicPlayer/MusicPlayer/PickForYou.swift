//
//  PickForYou.swift
//  MusicPlayer
//
//  Created by Silverhand on 2022/9/26.
//

import SwiftUI

struct PickForYou: View
{
    @State private var SliderInitialplace = 0.0
    var body: some View
    {
      Color.white.edgesIgnoringSafeArea(.all)
      Text("Pick").foregroundColor(.black)
    }
}
    
struct PickForYou_Previews: PreviewProvider
{
    static var previews: some View
    {
        PickForYou()
    }
}
