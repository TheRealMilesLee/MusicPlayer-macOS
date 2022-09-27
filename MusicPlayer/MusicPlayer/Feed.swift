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
      //TODO: 找个方法用Grid来进行布局
    ZStack
    {
      VStack
      {


        Text("Feed").fontWeight(.semibold).font(.system(size:20, weight: .bold, design: .serif)).padding(.all).position(.init(x: 40, y: 30))
        HStack
        {
          ZStack
          {
            Button("Pick for you")
            {
              self.PickClick.toggle()
            }.padding().offset(x:-200, y: -100)
            if (PickClick)
            {
              PickForYou()
            }
          }
          ZStack
          {
            Button("Start Listening")
            {
              self.StartListeningClick.toggle()
            }.offset(x:0, y: -100)
            if (StartListeningClick)
            {
              StartListening()
            }
          }
          ZStack
          {
            Button("Personal Radio")
            {
              self.PersonalRadioClick.toggle()
            }.offset(x:200, y: -100)
            if (PersonalRadioClick)
            {
              PersonalRadio()
            }
          }
        }
      }
    }.padding(.all)
  }
}



