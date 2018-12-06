import Foundation

extension Calendar
{
    func startOfMonth(for date: Date) -> Date
    {
        let cal = Calendar.current
        let convDate = cal.dateComponents([.year,.month], from: date)
        return cal.date(from: convDate)!
    }
}
