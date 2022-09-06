//
//  GameStartView.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/08/23.
//

import SwiftUI

struct GameStartView: View {
    
    @State private var selectionValue = 1
    
    @ObservedObject var sensor : MotionSensor

       var body: some View {
           ZStack(){
               Color("backGroundColor")
                   .edgesIgnoringSafeArea(.all)
           VStack(spacing: 50) {
               Spacer()
               
               Image("title")
                   .resizable()
                   .frame(width: 250, height: 80, alignment: .center)
               
               Text("プレイヤー人数: 　\(selectionValue)人")
                   .foregroundColor(Color("textColor"))
                   .font(.title2)
//                   .foregroundColor(Color(red: 51, green: 51, blue: 51))
               
               Picker(selection: $selectionValue, label: Text("参加人数")) {
                   ForEach(1..<5){ index in
                       Text("\(index)人")
                           .foregroundColor(Color("textColor"))
                           .tag(index)

                   }
               }.pickerStyle(SegmentedPickerStyle())
                   .padding()

           
           Spacer()
           
           Button{
               for number in 0..<selectionValue {
                   sensor.persons.append("プレイヤー" + String(number + 1))
               }
               sensor.start()
               sensor.isShow = true
           }label: {
               Text("ゲームスタート")
                   .foregroundColor(Color.white)
                   .frame(width: 200, height: 100)
                   .background(Color.orange)
           }.border(Color.black)
               .cornerRadius(10)
           
           Spacer()
           
       }
       }
}
}
