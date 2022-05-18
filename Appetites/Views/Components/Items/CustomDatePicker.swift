//
//  CustomDatePicker.swift
//  Appetites
//
//  Created by chavin Panicharoen on 8/2/2565 BE.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @State private var isLoading:Bool = false
    @EnvironmentObject private var eventService:EventDataService
    @EnvironmentObject private var userService:UserDataService
    @Binding var currentDate:Date
    @State private var actualMonth:Int = 0
    @State private var currentMonth:Int = 0
    @State var event: GetEventResponse = GetEventResponse(events: [])
    @State var eventDateArray:[Int] = []
    
    var body: some View {
        ZStack {
            VStack (spacing:36) {
                
                let days:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
                
                HStack (spacing:20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(extraDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(extraDate()[1])
                            .font(.title.bold())
                            .foregroundColor(Color("NoirGreen"))
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation {
                            isLoading.toggle()
                            eventDateArray = []
                            currentMonth -= 1
                            actualMonth -= 1
                            print("CONTINUE ACTUAL \(actualMonth)")
                            eventService.getEvent(token: userService.token, month: "\(actualMonth)", year: "2022")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                eventService.event.events.forEach { event in
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd"
                                    eventDateArray.append(Int(dateFormatter.string(from: event.extractedDate)) ?? 0)
                                }
                                isLoading.toggle()
                            }
                            print("date array = \(eventDateArray)")
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color("NoirGreen"))
                    }
                    
                    Button {
                        withAnimation {
                            isLoading.toggle()
                            eventDateArray = []
                            currentMonth += 1
                            actualMonth += 1
                            print("CONTINUE ACTUAL \(actualMonth)")
                            eventService.getEvent(token: userService.token, month: "\(actualMonth)", year: "2022")
                            let formatter = DateFormatter()
                            formatter.dateFormat = "MM"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                eventService.event.events.forEach { event in
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd"
                                    eventDateArray.append(Int(dateFormatter.string(from: event.extractedDate)) ?? 0)
                                }
                                isLoading.toggle()
                            }
                            print("date array = \(eventDateArray)")
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(Color("NoirGreen"))
                    }

                    
                }
                .padding()
                
                HStack(spacing:0) {
                    ForEach(days,id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth:.infinity)
                    }
                }
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(extractDate()) { value in
                       CardView(value: value)
                    }
                }
                Spacer()
            }
            .onAppear(perform: {
                isLoading.toggle()
                let formatter = DateFormatter()
                formatter.dateFormat = "MM"
                actualMonth = Int(formatter.string(from: Date())) ?? 0
                eventService.getEvent(token: userService.token, month: "\(actualMonth)", year: "2022")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    eventService.event.events.forEach { event in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd"
                        eventDateArray.append(Int(dateFormatter.string(from: event.extractedDate)) ?? 0)
                    }
                    isLoading.toggle()
                }
                print("date array = \(eventDateArray)")
                
            })
            .foregroundColor(.white)
            .onChange(of:currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
            if isLoading {
                ProgressView("Loading")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("NoirGreen"))
                    .cornerRadius(10)
            }
        }
        
    }
    
    @ViewBuilder
    func CardView(value:DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .background(eventDateArray.contains(where: { $0 == value.day }) ? Color("NoirRed") : .clear)
                    .cornerRadius(eventDateArray.contains(where: { $0 == value.day }) ? 10 : 0)
            }
        }
        .padding(.vertical,8)
        .frame(height:60,alignment: .top)
    }
    
    func extraDate () -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month,value: self.currentMonth,to: Date()) else {
            return Date()
        }
    
        return currentMonth
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePicker(currentDate: .constant(Date()), event: GetEventResponse(events: [])).background(.black)
    }
}

extension Date{
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from:Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day,in: .month, for:startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day,value: day - 1,to:startDate)!
        }
    }
}
