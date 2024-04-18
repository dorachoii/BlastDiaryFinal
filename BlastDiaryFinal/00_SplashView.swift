import SwiftUI

struct SplashView: View{
    
    let orangeColor = Color(red: 252 / 255, green: 208 / 255, blue: 147 / 255)
    
    var body: some View{
        ZStack{
            Color(red: 39 / 255, green: 35 / 255, blue: 35 / 255).ignoresSafeArea()
            
            VStack{
                Image("splash")
                    .resizable()
                
                
            }
            
            Text("기록 시작하기!")
                .foregroundStyle(orangeColor)
                .padding(.top, 400)
        }

    }
}

#Preview {
    SplashView()
}
