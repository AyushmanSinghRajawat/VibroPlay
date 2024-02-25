import SwiftUI

struct HomeScreenView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                WelcomeView()
                ActivityView()
                ContinueView()
                InstrumentsView()
                SongBookView()
            }
        }
        .background(Color.black)
        .preferredColorScheme(.light)
    }
}

struct WelcomeView: View {
    
    @State var progressValue: Float = 0.0

    var body: some View {
        HStack() {
            if #available(iOS 16.0, *) {
                Text("Welcome")
                    .padding(.leading)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            } else {
                // Fallback on earlier versions
            }
            Spacer()
            CircularProgressBarView(progress: self.$progressValue)
                .padding(.trailing)
                .frame(width: 80, height: 80)
                .onAppear() {
                    self.progressValue = 0.2
                }
        }
    }
}

struct CircularProgressBarView: View {
    
    @Binding var progress: Float
    var color: Color = .green
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                Image(systemName: "person.fill")
                    .renderingMode(.original)
                    .font(.largeTitle)
            Circle()
                .stroke(lineWidth: 8.0)
                .opacity(1.0)
                .foregroundColor(.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

struct ActivityView: View {
    
    @State var shouldPresentOngoingScreenView = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: .infinity, height: 195)
                .foregroundColor(Color.init(red: 38/255, green: 37/255, blue: 38/255))
            VStack(alignment: .leading) {
                HStack {
                    Text("Guitar")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.top)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.title)
                        .padding(.trailing)
                        .foregroundColor(.white)
                    .onTapGesture(count: 1, perform: {
                        self.shouldPresentOngoingScreenView = true
                    })
                    .fullScreenCover(isPresented: $shouldPresentOngoingScreenView, content: {
                        OngoingScreenView()
                    })
                }
                ProgressBarView()
                    .padding(.leading)
                    .padding(.trailing, 30)
                HStack {
                    Text("Basics of chords")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.top, 3)
                    Spacer()
                    Text("15%")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 3)
                }
                ZStack() {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 40)
                        .padding(.leading)
                        .padding(.top, 8)
                        .foregroundColor(Color.init(red: 63/255, green: 63/255, blue: 66/255))
                    Text("View Progress")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.top, 5)
                }
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct ProgressBarView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: .infinity, height: 10)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 0)
                .frame(width: 60, height: 7)
                .foregroundColor(.green)
                .padding(.leading, 5)
        }
    }
}

struct ContinueView: View {
    
    @State var shouldPresentChordView = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Text("Continue")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ContinueCellView(chord: "E")
                            .onTapGesture(count: 1, perform: {
                                self.shouldPresentChordView = true
                            })
                            .fullScreenCover(isPresented: $shouldPresentChordView, content: {
                                ChordView()
                            })
                        ContinueCellView(chord: "B")
                        ContinueCellView(chord: "D")
                    }
                    .padding(.leading)
                }
            }
        }
    }
}

struct ContinueCellView: View {
    
    var chord: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color.init(red: 38/255, green: 37/255, blue: 38/255))
                .frame(width: 190, height: 80)
            HStack {
                Circle()
                    .fill(
                        LinearGradient(gradient:
                        Gradient(colors: [Color.yellow, Color.red]),
                        startPoint: .top,
                        endPoint: .bottom)
                    )
                    .frame(width: 60, height: 60)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                VStack(spacing: 5) {
                    Text("Chord \(self.chord)")
                        .foregroundColor(.white)
                    Text("Guitar")
                        .foregroundColor(.gray)
                        .padding(.leading, -12)
                }
            }
            Text(self.chord)
                .font(.title2)
                .padding(.leading, 33)
                .padding(.top, 26)
                .foregroundColor(.black)
        }
    }
}

struct InstrumentsView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil)
    ]
    
    var widthHeight: CGFloat = 80.0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Text("Instruments")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: .infinity, height: widthHeight+30)
                        .foregroundColor(Color.init(red: 38/255, green: 37/255, blue: 38/255))
                        .padding(.leading)
                    LazyVGrid(columns: columns, content: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: widthHeight, height: widthHeight)
                                .foregroundColor(.green)
                            Image(systemName: "guitars")
                                .renderingMode(.original)
                                .font(.largeTitle)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: widthHeight, height: widthHeight)
                                .foregroundColor(.pink)
                            Image(systemName: "pianokeys")
                                .renderingMode(.original)
                                .font(.largeTitle)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: widthHeight, height: widthHeight)
                                .foregroundColor(.blue)
                            Image(systemName: "music.mic")
                                .renderingMode(.original)
                                .font(.largeTitle)
                        }
                    })
                    .padding(.leading, 25)
                    .padding(.trailing, 10)
                }
            }
        }
        .padding(.trailing)
    }
}

struct SongBookView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil),
    ]
    
    @State var shouldPresentAudioPlayerView = false
    var widthHeight: CGFloat = 120
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Text("Song Book")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: .infinity, height: widthHeight+40)
                        .foregroundColor(Color.init(red: 38/255, green: 37/255, blue: 38/255))
                        .padding(.leading)
                    LazyVGrid(columns: columns, content: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: widthHeight, height: widthHeight)
                                .foregroundColor(.green)
                            Image("birthday")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: widthHeight, height: widthHeight)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            Image(systemName: "music.note")
                                .renderingMode(.original)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.top, -60)
                            Text("  Happy \nBirthday")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 60)
                        }
                        .onTapGesture(count: 1, perform: {
                            self.shouldPresentAudioPlayerView = true
                        })
                        .fullScreenCover(isPresented: $shouldPresentAudioPlayerView, content: {
                            AudioPlayerView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
                        })
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: widthHeight, height: widthHeight)
                                .foregroundColor(.pink)
                            Image("christmasTree")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: widthHeight, height: widthHeight)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            Image(systemName: "music.note")
                                .renderingMode(.original)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.top, -60)
                            Text("     Merry \nChristmas")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 60)
                        }
                    })
                    .padding(.leading, 25)
                    .padding(.trailing, 10)
                }
            }
        }
        .padding(.trailing)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

