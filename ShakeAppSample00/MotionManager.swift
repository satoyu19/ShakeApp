//
//  MotionManager.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/07/27.
//

import CoreMotion

final class MotionManager {
    
    static let shared: MotionManager = .init()
    
    private let motion = CMMotionManager()
    
    private let queue = OperationQueue()
    
    //振った回数
    private var currentShake: Int = 0
    
    //ゲームオーバーの基準
    //TODO: 人数によって可変するようにしたい。
    private let limitShake: Int = 0
    
    private init(){}
    
    func startQueueUpDates(){
        //速度センサーが利用可能か
        guard motion.isAccelerometerAvailable else { return }
        
        //ブロックハンドラーに加速度計の更新を提供するための間隔（秒単位）。
        motion.accelerometerUpdateInterval = 6.0 / 60.0
        
        //操作キューで、指定されたハンドラーを使用して加速度計の更新を開始します。
        motion.startAccelerometerUpdates(to: queue, withHandler: { data, error in
            
        })
        //func stopAccelerometerUpdates()　→ 加速度計の更新を停止します。
    }
}
//エラーを理解する
//let CMErrorDomain: String
//CoreMotionのエラードメイン。
//struct CMError
//モーションエラーを定義します。

