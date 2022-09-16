//
//  IntroView.swift
//  ShakeAppSample00
//
//  Created by cmStudent on 2022/09/06.
//

import SwiftUI
import EAIntroView

enum Description: String{
    case sampleDescription1 = "まずはタイトル画面からゲームの参加人数を選択してください。参加人数が選択できましたらゲームを開始します。スタートボタンを押してください。"
    case sampleDescription2 = "最初のプレイヤーからデバイスを上下に振ってください、ビンの栓がどんどん外れていく・・・。好きなタイミングで次のプレイヤーへ順番を移します、ボタンを押してください。ビンの栓を外したプレイヤーの負けです！！！"
}

struct IntroView: View {
    
    var parent: ContentView
    
    init(parent: ContentView){
        self.parent = parent
    }
}

extension IntroView: UIViewRepresentable{
   
    
    typealias UIViewType = EAIntroView
    
    func updateUIView(_ uiView: EAIntroView, context: Context) {}
    
    //    Coordinatorインスタンスの生成、自身(contentView)を渡す
        func makeCoordinator() -> Coordinator {
//            Coordinator(self)
            Coordinator(parent)
        }
    
    func makeUIView(context: Context) -> EAIntroView {
        //画面サイズを指定
        let view = UIView(frame: UIScreen.main.bounds)

        //表示するページの生成、その他フィールド値あり
        let page1 = EAIntroPage()
        page1.title = "タイトル画面"
        page1.desc = Description.sampleDescription1.rawValue
        page1.bgImage = UIImage(named: "bg")
        page1.titleIconView = UIImageView(image: UIImage(named: "titlestart")?.ResizeUIImage(width: 200, height:  400))

        let page2 = EAIntroPage()
        page2.title = "ゲーム画面"
        page2.desc = Description.sampleDescription2.rawValue
        page2.bgImage = UIImage(named: "bg")
        page2.titleIconView = UIImageView(image: UIImage(named: "titlegame")?.ResizeUIImage(width: 200, height:  400))

        //ウォークスールー一連
        let intro = EAIntroView(frame: view.bounds, andPages: [page1, page2]);
        intro?.delegate = context.coordinator
        intro?.skipButtonAlignment = .center
        intro?.skipButtonY = 80
        intro?.pageControlY = 42
        intro?.show(in: view, animateDuration: 0.3)

        view.addSubview(intro!)

        return intro!

    }
}

class Coordinator: NSObject, EAIntroDelegate {
    //親viewの初期化
    var parent: ContentView

    init(_ parent: ContentView) {
        self.parent = parent
    }

    //イントロが終わった時の呼び出し、通常終了 or skip
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        parent.sensor.viewState = .title
    }
}

//リサイズできるように拡張
extension UIImage{
    func ResizeUIImage(width : CGFloat, height : CGFloat)-> UIImage!{

            // 指定された画像の大きさのコンテキストを用意.
            UIGraphicsBeginImageContext(CGSize(width: width, height: height))

            // コンテキストに自身に設定された画像を描画する.
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

            // コンテキストからUIImageを作る.
            let newImage = UIGraphicsGetImageFromCurrentImageContext()

            // コンテキストを閉じる.
            UIGraphicsEndImageContext()

            return newImage
        }

}

