import Foundation

enum Week: Int, CaseIterable
{
   case monday = 0
   case tuesday = 1
   case wednesday = 2
   case thursday = 3
   case friday = 4
   case saturday = 5
   case sunday = 6
   
   var name: String {
      switch self {
      case .monday:    return "Monday"
      case .tuesday:   return "Tuesday"
      case .wednesday: return "Wednesday"
      case .thursday:  return "Thursday"
      case .friday:    return "Friday"
      case .saturday:  return "Saturday"
      case .sunday:    return "Sunday"
      }
   }
}
