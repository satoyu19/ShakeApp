//
//  MotionSensor.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/08/24.
//

import CoreMotion
import UIKit

//TODO: contentと同じMotionSensorを渡すよう改善する
class MotionSensor: NSObject, ObservableObject {
    
    @Published var yStr = 0.0
    
    @Published var shakeCount = 0
    
    @Published var result = "振って振って"
    
    @Published var viewState: Flag = .intro
    
    @Published var player = "プレイヤー１"
    
    @Published var persons = [String]()
    
    @Published var imgString = "gameimg1"
    
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
        
        viewState = .start
    }
    
    func stop() {
        viewState = .out
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
            imgString = "gameimg2"
        } else if(shakeCount > 20){
            result = "アウト!!!\(player)の負けです!!!"
            imgString = "gameimg3"
            feedbackGenerator.impactOccurred()
            stop()
        }
    }
    
    func reset(){
        viewState = .title
        shakeCount = 0
        result = "振ってふって"
        imgString = "gameimg1"
    }
}

enum Flag{
    case start
    case title
    case intro
    case out
}
