import Foundation

class Predicates
{
    static func filterMonth(forDate date: Date, attribute: String) -> NSPredicate
    {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let dateFrom = calendar.startOfMonth(for: date)
        let dateToOpt = calendar.date(byAdding: .month, value: 1, to: dateFrom)
        
        guard let dateTo = dateToOpt else {
            fatalError("Predicated: Failed to create dateTo")
        }
        
        return NSPredicate(format: "\(attribute) >= %@ AND \(attribute) < %@",
                           argumentArray: [attribute, dateFrom, attribute, dateTo])
    }
    
    static func filterDay(forDate date: Date, attribute: String) -> NSPredicate
    {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let dateFrom = calendar.startOfDay(for: date)
        let dateToOpt = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        
        guard let dateTo = dateToOpt else {
            fatalError("Predicated: Failed to create dateTo")
        }
        
        return NSPredicate(format: "\(attribute) >= %@ AND \(attribute) < %@",
                           argumentArray: [dateFrom, dateTo])
    }
}
