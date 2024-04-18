import SwiftUI
import SwiftData

//01. Model 생성
//unique로

@Model
class Diary{
    
    var date: Date
    var moodText: String
    var diaryText: String
    var status: Status
    
    init(date: Date, moodText: String, diaryText: String, status: Status) {
        self.date = date
        self.moodText = moodText
        self.diaryText = diaryText
        self.status  = status
    }
    
    var icon: Image {
        switch status {
        case .blasted:
            Image("crack")
        case .notyet:
            Image("bubble")
        case .empty:
            Image("")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable{
    case blasted, notyet, empty
    
    var id: Self{
        self
    }
    
    var description: String{
        switch self{
        case .blasted:
            "crack"
        case .notyet:
            "bubble"
        case .empty:
            "empty"
        }
    }
}
