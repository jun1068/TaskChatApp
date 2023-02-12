//
//  DateExtension2.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2023/01/29.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
}
extension Date {
    // ◯秒前
    func secondBefore(_ second: Int) -> Date {
        let day = Calendar.current.date(byAdding: .second, value: -second, to: self)
        return day!
    }

    // ◯秒後
    func secondAfter(_ second: Int) -> Date {
        let day = Calendar.current.date(byAdding: .second, value: second, to: self)
        return day!
    }

    // ◯分前
    func minuteBefore(_ minute: Int) -> Date {
        let day = Calendar.current.date(byAdding: .minute, value: -minute, to: self)
        return day!
    }

    // ◯分後
    func minuteAfter(_ minute: Int) -> Date {
        let day = Calendar.current.date(byAdding: .minute, value: minute, to: self)
        return day!
    }

    // ◯時間前
    func hourBefore(_ hour: Int) -> Date {
        let day = Calendar.current.date(byAdding: .hour, value: -hour, to: self)
        return day!
    }

    // ◯時間後
    func hourAfter(_ hour: Int) -> Date {
        let day = Calendar.current.date(byAdding: .hour, value: hour, to: self)
        return day!
    }

    // その日の0時00分
    var startTime: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
extension Date {
    var yesterday: Date {
        let day = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return day!
    }

    var tomorrow: Date {
        let day = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return day!
    }

    // 1週間前
    var oneWeekBefore: Date {
        let day = Calendar.current.date(byAdding: .day, value: -7, to: self)
        return day!
    }

    // 1週間後
    var oneWeekAfter: Date {
        let day = Calendar.current.date(byAdding: .day, value: 7, to: self)
        return day!
    }

    // 1ヶ月前
    var oneMonthBefore: Date {
        let day = Calendar.current.date(byAdding: .month, value: -1, to: self)
        return day!
    }

    // 1ヶ月後
    var oneMonthAfter: Date {
        let day = Calendar.current.date(byAdding: .month, value: 1, to: self)
        return day!
    }

    // 1年前
    var oneYearBefore: Date {
        let day = Calendar.current.date(byAdding: .year, value: -1, to: self)
        return day!
    }

    // 1年後
    var oneYearAfter: Date {
        let day = Calendar.current.date(byAdding: .year, value: 1, to: self)
        return day!
    }

    // 月初
    var beginningOfTheMonth: Date {
        let component = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: component)!
    }

    // 月末
    var endOfTheMonth: Date {
        let beginningOfTheMonth = self.beginningOfTheMonth
        let add = DateComponents(month: 1, day: -1)
        return Calendar.current.date(byAdding: add, to: beginningOfTheMonth)!
    }

    // 年始
    var beginningOfTheYear: Date {
        let component = Calendar.current.dateComponents([.year], from: self)
        return Calendar.current.date(from: component)!
    }

    // 年末
    var endOfTheYear: Date {
        let beginningOfTheYear = self.beginningOfTheYear
        let add = DateComponents(year: 1, day: -1)
        return Calendar.current.date(byAdding: add, to: beginningOfTheYear)!
    }
}
extension Date {
    enum WeekDay: Int {
        case sunday = 0
        case monday = 1
        case tuesday = 2
        case wednesday = 3
        case thursday = 4
        case friday = 5
        case saturday = 6
    }

    var weekDayIndex: Int {
        let weekday = (Calendar.current as NSCalendar)
            .components( .weekday, from: self)
            .weekday!
        // index値を1-7から0-6に変換
        return weekday - 1
    }

    var weekDay: WeekDay {
        return WeekDay(rawValue: weekDayIndex)!
    }

    var isSunday: Bool {
        return weekDay == .sunday
    }

    var isMonday: Bool {
        return weekDay == .monday
    }

    var isTuesday: Bool {
        return weekDay == .tuesday
    }

    var isWednesday: Bool {
        return weekDay == .wednesday
    }

    var isThursday: Bool {
        return weekDay == .thursday
    }

    var isFriday: Bool {
        return weekDay == .friday
    }

    var isSaturday: Bool {
        return weekDay == .saturday
    }
}
extension Date {
    var yyyyMMddHHmmss: String {
        return DateFormatter.yyyyMMddHHmmss.string(from: self)
    }

    var yyyyMMddHHmm: String {
        return DateFormatter.yyyyMMddHHmm.string(from: self)
    }

    var yyyyMMdd: String {
        return DateFormatter.yyyyMMdd.string(from: self)
    }

    var MMdd: String {
        return DateFormatter.MMdd.string(from: self)
    }

    var HHmm: String {
        return DateFormatter.HHmm.string(from: self)
    }

    var kanjiyyyyMMddHHmmss: String {
        return DateFormatter.kanjiyyyyMMddHHmmss.string(from: self)
    }

    var kanjiyyyyMMddHHmm: String {
        return DateFormatter.kanjiyyyyMMddHHmm.string(from: self)
    }

    var kanjiyyyyMMdd: String {
        return DateFormatter.kanjiyyyyMMdd.string(from: self)
    }

    var kanjiMMdd: String {
        return DateFormatter.kanjiMMdd.string(from: self)
    }

    var kanjiHHmm: String {
        return DateFormatter.kanjiHHmm.string(from: self)
    }

    var kanjiyyyyMMddE: String {
        return DateFormatter.kanjiyyyyMMddE.string(from: self)
    }
}
extension DateFormatter {
    static var yyyyMMddHHmmss: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var yyyyMMddHHmm: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var yyyyMMdd: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var MMdd: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var HHmm: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    // MARK: kanji
    static var kanjiyyyyMMddHHmmss: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分ss秒"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var kanjiyyyyMMddHHmm: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var kanjiyyyyMMdd: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var kanjiMMdd: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM年dd月"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    static var kanjiHHmm: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH時mm分"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    // MARK: kanji with week
    static var kanjiyyyyMMddE: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日(E)"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }
}

