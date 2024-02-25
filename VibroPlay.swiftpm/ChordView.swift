import SwiftUI

struct ChordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 60) {
                    
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
                    
                    ChordTypeView()
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                        Spacer()
                        Image("chord")
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    Trinagle()
                        .frame(width: 100, height: 80)
                        .foregroundColor(.yellow)
                    Button(action: {
                        
                    }, label: {
                        CircularView()
                            .frame(width: 100, height: 100)
                    })
                    .withPressableStyle()
                }
            }
        }
        .background(Color.black)
        .preferredColorScheme(.light)
    }
}

struct ChordTypeView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.init(red: 29/255, green: 29/255, blue: 29/255))
                .frame(width: .infinity, height: 40)
            ScrollView(.horizontal) {
                let width = (UIScreen.main.bounds.width - 26)/4
                LazyHStack {
                    LevelCellView(level: "Em", selected: true, width: width)
                    LevelCellView(level: "EM", width: width)
                    LevelCellView(level: "C#", width: width)
                    LevelCellView(level: "C", width: width)
                }
            }
        }
    }
}

struct Trinagle: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct CircularView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.init(red: 50/255, green: 50/255, blue: 50/255))
                Text("E")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -20)
                Text("Minor")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, 25)
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.gray)
        }
    }
}

struct PressableButtonStyle: ButtonStyle {
    
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
    }
}

extension View {
    
    func withPressableStyle(scaleAmount: CGFloat = 1.2) -> some View {
        buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}

struct ChordView_Previews: PreviewProvider {
    static var previews: some View {
        ChordView()
    }
}
