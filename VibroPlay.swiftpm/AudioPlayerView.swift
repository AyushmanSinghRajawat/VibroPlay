import SwiftUI
import AVKit

struct AudioPlayerView: View {
    
    let audioFileName = "birthday"
    @Environment(\.presentationMode) var presentationMode
    
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animationContent: Bool = false
    
    @State var videoPlayerIcon = AVPlayer(url: Bundle.main.url(forResource: "playerIcon", withExtension: "mp4")!)
    @State var videoPlayerTune = AVPlayer(url: Bundle.main.url(forResource: "playerTune", withExtension: "mp4")!)
    
    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.leading, 20)
                        .padding(.top, 50)
                })
                Spacer()
            }
            
            VideoPlayer(player: videoPlayerIcon)
                .frame(width: 300, height: 100, alignment: .center)
                .disabled(true)
            
            GeometryReader{
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 30){
                        ZStack {
                            Image("birthday")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            Image(systemName: "music.note")
                                .aspectRatio(contentMode: .fill)
                                .padding(.top, -60)
                            Text("  Happy \nBirthday")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 60)
                        }
                        
                        VideoPlayer(player: videoPlayerTune)
                            .frame(width: 300, height: 100, alignment: .center)
                            .disabled(true)
                        
                        PlayerView(size)
                    }
                    
                    .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                    .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                    .padding(.horizontal, 25)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .clipped()
                }
                .ignoresSafeArea(.container, edges: .all)
            }
        }
        
        .background(Color.black)
        .preferredColorScheme(.light)
        
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
    }
    
    private func setupAudio(){
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3")
        else{
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        }catch {
            print("Errir loading audio: \(error)")
        }
    }
    
    private func playAudio(){
        player?.play()
        videoPlayerIcon.play()
        videoPlayerTune.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        videoPlayerIcon.pause()
        videoPlayerTune.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader{
            
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing){
                VStack(spacing: spacing){
                    Slider(value: Binding(get: {
                        currentTime
                    }, set: { newValue in
                        seekAudio(to: newValue)
                    }), in: 0...totalTime)
                    .accentColor(.white)
                    
                    HStack{
                        Text(timeString(time: currentTime))
                        Spacer()
                        Text(timeString(time: totalTime))
                    }
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18){
                    Button{
                        
                    }label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    .disabled(true)
                    
                    Button{
                        
                    }label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                            .onTapGesture {
                                isPlaying ? stopAudio() : playAudio()
                            }
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    .disabled(true)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
            .preferredColorScheme(.dark)
    }
}

extension View{
    var deviceCornerRadius: CGFloat {
        
        let key = "_displayCornerRadius"
        
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen{
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0
    }
}
