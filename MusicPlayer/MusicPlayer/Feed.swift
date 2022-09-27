  //
  //  Feed.swift
  //  MusicPlayer
  //
  //  Created by Silverhand on 2022/9/26.
  //

import SwiftUI

struct Feed: View
{
  @State var PickClick = false
  @State var StartListeningClick = false
  @State var PersonalRadioClick = false
  var body: some View
  {

    ZStack
    {
      Text("Feed").fontWeight(.semibold).font(.system(size:20, weight: .bold, design: .serif)).multilineTextAlignment(.leading).padding(.all).position(.init(x: 40, y: 30)).offset(x: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)

      Button("Pick for you")
      {
        self.PickClick.toggle()
      }.padding().offset(x:-200, y: -100)
      if (PickClick)
      {
        PickForYou()
      }

      Button("Start Listening")
      {
        self.StartListeningClick.toggle()
      }.offset(x:0, y: -100)
      if (StartListeningClick)
      {
        Color.white.edgesIgnoringSafeArea(.all)
        StartListening()
      }

      Button("Personal Radio")
      {
        self.PersonalRadioClick.toggle()
      }.offset(x:200, y: -100)
      if (PersonalRadioClick)
      {
        Color.white.edgesIgnoringSafeArea(.all)
        PersonalRadio()
      }
    }
    .padding(.all)
  }
}



struct Feed_Previews: PreviewProvider {
  static var previews: some View {
    Feed()
  }
}
