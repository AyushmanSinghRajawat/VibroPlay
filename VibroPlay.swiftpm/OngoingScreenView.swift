import SwiftUI

struct OngoingScreenView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let upcomingLesson: [[String:String]] = [["title": "Fingerpicking Basics", "lesson": "Lesson 2"], ["title": "Basic Music Theory", "lesson": "Lesson 3"], ["title": "Strumming Patterns", "lesson": "Lesson 4"], ["title": "Guitar Tabs", "lesson": "Lesson 5"]]
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 15) {
                    
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
                    
                    LevelView()
                    HStack {
                        Text("Ongoing")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    BasicChordsView()
                    HStack {
                        Text("Upcoming")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    ForEach(self.upcomingLesson.indices) { index in
                        UpcomingCellView(lesson: self.upcomingLesson[index])
                    }
                }
            }
        }
        .background(Color.black)
        .preferredColorScheme(.light)
    }
}

struct LevelView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.init(red: 29/255, green: 29/255, blue: 29/255))
                .frame(width: .infinity, height: 40)
            ScrollView(.horizontal) {
                LazyHStack {
                    LevelCellView(level: "Basic", selected: true)
                    LevelCellView(level: "Intermediate")
                    LevelCellView(level: "Advanced")
                    LevelCellView(level: "Expert")
                }
            }
        }
    }
}

struct LevelCellView: View {
    
    var level: String
    var selected: Bool = false
    var width: CGFloat = 130
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.selected ? Color.init(red: 99/255, green: 99/255, blue: 99/255) : Color.init(red: 40/255, green: 40/255, blue: 40/255))
                .frame(width: self.width, height: 40)
            Text(self.level)
                .font(.body)
                .foregroundColor(self.selected ? .white : .gray)
        }
    }
}

struct BasicChordsView: View {
    
    @State var shouldPresentChordView = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: .infinity, height: 135)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                HStack {
                    Text("Basic Chords")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading)
                        .padding(.top)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.title)
                        .padding(.trailing)
                        .foregroundColor(.black)
                    .onTapGesture(count: 1, perform: {
                        self.shouldPresentChordView = true
                    })
                    .fullScreenCover(isPresented: $shouldPresentChordView, content: {
                        ChordView()
                    })
                }
                HStack {
                    Text("Introduction to chords")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.leading)
                    Spacer()
                }
                Text("Lesson 1")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.leading)
                    .padding(.top, 20)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct UpcomingCellView: View {
    
    var lesson: [String:String]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: .infinity, height: 90)
                .foregroundColor(Color.init(red: 40/255, green: 40/255, blue: 40/255))
            VStack(alignment: .leading) {
                HStack {
                    Text(self.lesson["title"] ?? "")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.top)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.title)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(self.lesson["lesson"] ?? "")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.top, 5)
                    Spacer()
                }
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct OngoingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingScreenView()
    }
}
