import CoreData
import Foundation

enum RecordType: Int64 {
   case work = 0
   case vacation = 1
   case sickness = 2
   
   func description() -> String {
      switch self {
      case .work: return "Work"
      case .vacation: return "Vacation"
      case .sickness: return "Sickness"
      }
   }
}

extension Record {
   var type: RecordType {
      get { return RecordType(rawValue: typeRaw) ?? .work }
      set { typeRaw = newValue.rawValue }
   }
}
