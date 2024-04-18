import SwiftUI
import SpriteKit
import GameplayKit

struct ContentView: View {
    
    @State private var showMainView = false
    let orangeColor = Color(red: 252 / 255, green: 208 / 255, blue: 147 / 255)
    
    @Environment(\.modelContext) var modelContext
    
    var gameScene: SKScene {
        
        let gameScene = GameScene(/*moodText: $moodText*/)
        gameScene.size = CGSize(width: 1200, height: 1200)
        gameScene.scaleMode = .aspectFill
        
        return gameScene
    }
    
    var body: some View {
        ZStack{
            if showMainView{
                Color(red: 39 / 255, green: 35 / 255, blue: 35 / 255).ignoresSafeArea()
//                ZStack{
//                    SpriteView(scene: gameScene)
//                    Text("화남")
//                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                        .foregroundStyle(orangeColor)
//                        .padding(.bottom, 250)
//                }
                
                CalendarView()
            }else{
                SplashView().onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){withAnimation{
                        showMainView = true
                    }}
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

