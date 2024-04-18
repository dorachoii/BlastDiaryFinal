import SwiftUI
import SwiftData

//CRUD가 모두 가능해야 함!

struct DiaryView : View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Binding var selectedDay: Date?
    
    //여기서 받아와서 selectedDay와 같다면으로 짜야 함!
    //date로 필터
    @Query private var diarys: [Diary]
    
    let maxDiaryText = 100
    let maxMoodText = 4
    let orangeColor = Color(red: 252 / 255, green: 208 / 255, blue: 147 / 255)
    
    @State private var episodeText: String = ""
    @State private var moodText: String = ""
    @State private var isPresented = false
    @State private var status: Status = Status.empty
    
    var body : some View{
        ZStack{
            
            Color(red: 39 / 255, green: 35 / 255, blue: 35 / 255).ignoresSafeArea()
            
            VStack{
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image("cancelBtn")
                    }
                }
                .padding()
                Spacer()
            }
            
            VStack(alignment: .leading) {
                
//                if(!diarys.isEmpty){
//                    
//                    ForEach(diarys){ diary in
//                        //episodeText = diary.diaryText
//                        // 해당 날짜가 생성되어 있다면 수정하기!
//                        // 삭제하기
//                        if(diary.date == selectedDay){
//                            if(!diary.diaryText.isEmpty){
//                                HStack{
//                                    // Update는 이미 반영이 되기 때문에 안해줘도 됌
//                                    Spacer()
//                                    
//                                    // Delete
//                                    Button(action: {
//                                        context.delete(diary)
//                                    }, label: {
//                                        
//                                        Text("삭제")
//                                            .padding(.horizontal, 20)
//                                    })
//                                }
//                            }
//                            
//                            ZStack{
//                                Image("bubble")
//                                    .resizable()
//                                    .frame(width: 400, height: 400)
//                                
//                                VStack {
//                                    //if // 작성, 읽기모드 구분 {
//                                    //if diary.diaryText != "" { 수정모드
//                                    Text(diary.diaryText)
////                                    TextField("", text: diary.diaryText)
////                                        .foregroundColor(orangeColor)
////                                        .padding()
////                                        .background(Color.white.opacity(0))
////                                        .cornerRadius(10)
////                                        .padding()
////                                        .frame(width: 200)
////                                        .multilineTextAlignment(.center)
////                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                                    // else if diary.diaryText == "" { // 작성모드
//                                    TextField("", text: $moodText)
//                                        .foregroundColor(orangeColor)
//                                        .padding()
//                                        .background(Color.white.opacity(0))
//                                        .cornerRadius(10)
//                                        .padding()
//                                        .frame(width: 200)
//                                        .multilineTextAlignment(.center)
//                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
////                                        .onChange(of: moodText) {
////                                            diary.diaryText = moodText
////                                        }
//                                    //}
//                                    // 읽기
//                                }.onChange(of: moodText){ newValue in
//                                    if newValue.count > maxMoodText {
//                                        moodText = String(newValue.prefix(maxMoodText))
//                                    }
//                                }
//                                .onAppear {
//                                    // moodText = di
//                                }
//                            }
//                            
//                            VStack {
//                                // 옵셔널 언래핑 하기
//                                Text("\(selectedDay?.displayFormat3 ?? Date().formatted())")
//                                    .foregroundColor(orangeColor)
//                                    .font(.title)
//                                    .bold()
//                                    .padding(.horizontal, 20)
//                            }
//                            
//                            VStack {
//                                
//                                // 여기 고쳐야 함
//                                ZStack(alignment: .topLeading) {
//                                    
//                                    TextEditor(text: $episodeText)
//                                        .scrollContentBackground(.hidden)
//                                        .foregroundColor(orangeColor)
//                                        .textFieldStyle(.roundedBorder)
//                                        .padding(20)
//                                    
//                                    
//                                    // 글자 수 제한
//                                }.onChange(of: diary.diaryText) { newValue in
//                                    
//                                    if newValue.count > maxDiaryText {
//                                        diary.diaryText = String(newValue.prefix(maxDiaryText))
//                                    }
//                                }
//                            }
//                        }
                        // 해당 날짜가 생성되어 있지 않다면 쓰기
//                        else{
                            
                            HStack{
                                // Create - 저장
                                Button(action: {
                                    if let selectedDay {
                                        let newDiary = Diary(date: selectedDay, moodText: moodText, diaryText: episodeText, status: status)
                                        print("ok:\(newDiary.moodText)")
                                        context.insert(newDiary)
                                    }
                                    
                                }, label: {
                                    Text("완료")
                                        .padding(.horizontal, 20)
                                })
                                
                                Spacer()
                            }
                            
                            
                            ZStack{
                                Image("bubble")
                                    .resizable()
                                    .frame(width: 400, height: 400)
                                
                                VStack {
                                    TextField("", text: $moodText)
                                        .foregroundColor(orangeColor)
                                        .padding()
                                        .background(Color.white.opacity(0))
                                        .cornerRadius(10)
                                        .padding()
                                        .frame(width: 200)
                                        .multilineTextAlignment(.center)
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                }.onChange(of: moodText){ newValue in
                                    if newValue.count > maxMoodText {
                                        moodText = String(newValue.prefix(maxMoodText))
                                    }
                                }
                            }
                            
                            VStack {
                                // 옵셔널 언래핑 하기
                                Text("\(selectedDay?.displayFormat3 ?? Date().formatted())")
                                    .foregroundColor(orangeColor)
                                    .font(.title)
                                    .bold()
                                    .padding(.horizontal, 20)
                            }
                            
                            VStack {
                                
                                // 여기 고쳐야 함
                                ZStack(alignment: .topLeading) {
                                    if episodeText.isEmpty {
                                        Text("오늘의 감정을 기록해보세요!")
                                            .padding(27)
                                            .foregroundColor(orangeColor)
                                    } else {
                                        EmptyView()
                                    }
                                    
                                    TextEditor(text: $episodeText)
                                        .scrollContentBackground(.hidden)
                                        .foregroundColor(orangeColor)
                                        .textFieldStyle(.roundedBorder)
                                        .padding(20)
                                    
                                    
                                    // 글자 수 제한
                                }.onChange(of: episodeText) { newValue in
                                    
                                    if newValue.count > maxDiaryText {
                                        episodeText = String(newValue.prefix(maxDiaryText))
                                    }
                                }
                            }
                            
                        }
                        
                    //}
                    
                    
//                }else{
//                    HStack{
//                        // Create - 저장
//                        Button(action: {
//                            let newDiary = Diary(date: selectedDay!, moodText: moodText, diaryText: episodeText, status: status)
//                            context.insert(newDiary)
//                            
//                            // ****** 터뜨리기 버튼 띄우기
//                            
//                        }, label: {
//                            Text("완료")
//                                .padding(.horizontal, 20)
//                        })
//                        
//                        Spacer()
//                    }
//                    
//                    
//                    ZStack{
//                        Image("bubble")
//                            .resizable()
//                            .frame(width: 400, height: 400)
//                        
//                        VStack {
//                            TextField("", text: $moodText)
//                                .foregroundColor(orangeColor)
//                                .padding()
//                                .background(Color.white.opacity(0))
//                                .cornerRadius(10)
//                                .padding()
//                                .frame(width: 200)
//                                .multilineTextAlignment(.center)
//                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                        }.onChange(of: moodText){ newValue in
//                            if newValue.count > maxMoodText {
//                                moodText = String(newValue.prefix(maxMoodText))
//                            }
//                        }
//                    }
//                    
//                    VStack {
//                        // 옵셔널 언래핑 하기
//                        Text("\(selectedDay?.displayFormat3 ?? Date().formatted())")
//                            .foregroundColor(orangeColor)
//                            .font(.title)
//                            .bold()
//                            .padding(.horizontal, 20)
//                    }
//                    
//                    VStack {
//                        
//                        // 여기 고쳐야 함
//                        ZStack(alignment: .topLeading) {
//                            if episodeText.isEmpty {
//                                Text("오늘의 감정을 기록해보세요!")
//                                    .padding(27)
//                                    .foregroundColor(orangeColor)
//                            } else {
//                                EmptyView()
//                            }
//                            
//                            TextEditor(text: $episodeText)
//                                .scrollContentBackground(.hidden)
//                                .foregroundColor(orangeColor)
//                                .textFieldStyle(.roundedBorder)
//                                .padding(20)
//                            
//                            
//                            // 글자 수 제한
//                        }.onChange(of: episodeText) { newValue in
//                            
//                            if newValue.count > maxDiaryText {
//                                episodeText = String(newValue.prefix(maxDiaryText))
//                            }
//                        }
//                    }
//                    
//                }
                
               
                
            }
        }
        
        
    }
    
    
    
    
    //#Preview {
    //    DiaryView(selectedDay: .constant(Date()))
    //}

