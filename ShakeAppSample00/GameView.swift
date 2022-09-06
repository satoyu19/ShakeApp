//
//  GameView.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/08/24.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var sensor : MotionSensor

    @State var playerCount = 0
    
    @State var playRound = 1
    
        var body: some View {
            ZStack{
                Color("backGroundColor")
                    .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                Text("\(String(playRound))周目")
//                    .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .trailing)
                    .offset(x: 100, y: 20)
                    .font(.title3)
                    .foregroundColor(Color("textColor"))
                    

                Image("watermark")
                    .resizable()
                    .frame(width: 200, height: 200)
                    
                
                Text(String(sensor.result))
                    .font(.title3)
                    .foregroundColor(Color("textColor"))
                
                Text(sensor.persons[playerCount])    //一人以上は確実に存在する
                    .font(.title3)
                    .foregroundColor(Color("textColor"))
                
                if(sensor.isStarted == true){
                    Button(action: {
                        if(sensor.persons.count - 1 > playerCount){
                            playerCount = playerCount + 1
                            sensor.player = sensor.persons[playerCount]
                        } else {
                            playerCount = 0
                            playRound = playRound + 1
                        }
                    }) {
                        Text("次のプレイヤーへ")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 100)
                            .background(Color.orange)
                    }
                } else {
                    Button(action: {
                        sensor.reset()
                    }) {
                        Text("タイトル画面へ")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 100)
                            .background(Color.orange)
                    }
                }
            }
            }
        }
}



