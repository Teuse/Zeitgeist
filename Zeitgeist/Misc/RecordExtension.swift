import Foundation

extension Record
{
    var duration: TimeInterval {
        let to = end ?? Date()
        let elapsed = to.timeIntervalSince(begin!)
        return elapsed
    }
    
    var isFinished: Bool {
        return end != nil
    }
}
