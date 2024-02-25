import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            HomeScreenView()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("VibroPlay")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
                    self.isActive = true
                })
            }
            .preferredColorScheme(.light) 
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
