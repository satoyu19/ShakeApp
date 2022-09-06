//
//  MotionSensor.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/08/24.
//

import Foundation
import CoreMotion
import UIKit

//TODO: contentと同じMotionSensorを渡すよう改善する
class MotionSensor: NSObject, ObservableObject {
    
    @Published var isStarted = false
    
    @Published var yStr = 0.0
    
    @Published var shakeCount = 0
    
    @Published var result = "振って振って"
    
    @Published var isShow = false
    
    @Published var player = "プレイヤー１"
    
    @Published var persons = [String]()
    
    let motionManager = CMMotionManager()
        
    //振動させる際に利用
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    func start() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }
        
        isStarted = true
    }
    
    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
    }
    
    //データ更新のたび呼び出される
    private func updateMotionData(deviceMotion:CMDeviceMotion) {
        yStr = deviceMotion.userAcceleration.y
        
        //y座標の取得する値が1以上の場合に振った回数をカウントアップする
        if(yStr > 1){
            shakeCount = shakeCount + 1
        }

        if(shakeCount > 10 && shakeCount < 20){
            result = "危ない！！！"
        } else if(shakeCount > 20){
            result = "アウト!!!\(player)の負けです!!!"
            feedbackGenerator.impactOccurred()
            stop()
        }
    }
    
    func reset(){
        isShow = false
        shakeCount = 0
        result = "振ってふって"
    }
}
