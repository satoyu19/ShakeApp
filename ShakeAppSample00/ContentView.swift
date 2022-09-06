//
//  ContentView.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/07/27.
//

import SwiftUI
import CoreMotion
//viewでは振っている場合にimageが変わる各基準値と比較しておき、imageを変更させる
struct ContentView: View {
    
    @ObservedObject var sensor = MotionSensor()

    var body: some View {
        if(sensor.isShow){
            GameView(sensor: sensor)
        } else {
            GameStartView(sensor: sensor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

