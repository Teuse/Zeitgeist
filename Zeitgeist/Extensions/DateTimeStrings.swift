import Foundation

func durationString(from timeInterval: TimeInterval) -> String
{
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .positional
    return formatter.string(from: timeInterval)!
}

func dateString(from date: Date) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy"
    return formatter.string(from: date)
}

func timeString(from date: Date) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm"
    return formatter.string(from: date)
}


//private func timeString(forDate date: Date) -> String {
//    let calendar = Calendar.current
//    let hour = calendar.component(.hour, from: date)
//    let minute = calendar.component(.minute, from: date)
//    return "\(hour):\(minute)"
//}
//
//private func timeStringLong(forDate date: Date) -> String {
//    let calendar = Calendar.current
//    let hour = calendar.component(.hour, from: date)
//    let minute = calendar.component(.minute, from: date)
//    let second = calendar.component(.second, from: date)
//    return "\(hour):\(minute):\(second)"
//}
