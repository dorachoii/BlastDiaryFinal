import SwiftUI
import SpriteKit
import SwiftData

struct CalendarView: View {
    
    //@Environment(\.modelContext) private var context // 하나만 하는 게 좋다!
    @Query(sort: \Diary.date) private var diarys: [Diary]
    @State private var createNewDiary = false
    
    // DiaryView로 넘길 것
    @State private var date = Date.now
    @State private var selectedDay: Date?
    
    // 달력 표시
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let day = 1..<32
    
    let orangeColor = Color(red: 252 / 255, green: 208 / 255, blue: 147 / 255)
    
    @State private var days: [Date] = []
    // modal창 변수
    @State private var isPresented = false
    
    
    var body: some View {
        ZStack{
            Color(red: 39 / 255, green: 35 / 255, blue: 35 / 255).ignoresSafeArea()
            
            VStack{
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    Text("기록할 날짜를 선택하세요!")
                        .font(.headline)
                        .foregroundColor(orangeColor)
                }
                
                VStack {
                    
                    // DatePicker
                    VStack(alignment: .center) {
                        DatePicker("", selection: $date)
                    }
                    .padding(.vertical)
                    
                    // Week
                    HStack {
                        ForEach(daysOfWeek.indices, id: \.self) { index in
                            Text(daysOfWeek[index])
                                .fontWeight(.medium)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical)
                    
                    // Calendar Grid
                    LazyVGrid(columns: columns) {
                        ForEach(days, id: \.self) { day in
                            if day.monthInt != date.monthInt {
                                Text("")
                            } else {
                                Button(action: {
                                    isPresented.toggle()
                                    selectedDay = day
                                }) {
                                    Text(day.formatted(.dateTime.day()))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            
                                            // diary Status 반영 이미지 표시
                                            
                                            ForEach(diarys) { diary in
                                                if(day == diary.date){
                                                    diary.icon
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                    
//                                                    Image("\(diary.status)")
//                                                        .resizable()
//                                                        .frame(width: 50, height: 50)
                                                }
                                            }
                                        )
                                }
                                .fullScreenCover(isPresented: $isPresented, content: {
                                    DiaryView(selectedDay: $selectedDay)
                                    
                                })
                            }
                        }
                        
                    }
                    .padding(.vertical)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 380, height: 400)
                )
                
                .onAppear() {
                    days = date.calendarDisplayDays
                }
                .onChange(of: date) {
                    days = date.calendarDisplayDays
                }
            }}
    }
}


#Preview {
    CalendarView()
}
