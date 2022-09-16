//
//  FlotingButton.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/09/16.
//

import SwiftUI

struct FloatingButton: View {
    
    @ObservedObject var sensor : MotionSensor

    var body: some View {
        ZStack{
            Color("backColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        sensor.viewState = .intro
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    })
                    .frame(width: 60, height: 60)
                    .background(Color.orange)
                    .cornerRadius(30.0)
                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                    
                }
            }
        }
    }
}
