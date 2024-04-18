import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    @State private var date = Date.now
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let day = 1..<32
    
    @State private var days: [Date] = []
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            // Calendar Color 선택
            VStack(alignment: .leading) {
                Text("Calendar Color")
                    .font(.headline)
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            .padding(.vertical)
            
            // Date/Time 선택
            VStack(alignment: .leading) {
                Text("Date/Time")
                    .font(.headline)
                DatePicker("", selection: $date)
            }
            .padding(.vertical)
            
            // 요일 표시
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.bold)
                        .foregroundColor(color)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical)
            
            // 달력 그리드
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Button(action: {
                            print("\(day)")
                            isPresented.toggle()
                        }) {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    Circle()
                                        .foregroundColor(
                                            Date.now.startOfDay == day.startOfDay ? .red.opacity(0.3) : color.opacity(0.3)
                                        )
                                )
                        }
                        .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
                    }
                }
            }
        }
        .padding()
        .onAppear() {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
}

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            HStack {
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Image("cancelBtn")
                            }
                        }
                        .padding()
        }
    }
}

#Preview {
    CalendarView()
}
