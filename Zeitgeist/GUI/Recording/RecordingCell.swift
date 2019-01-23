import Foundation
import UIKit

class RecordingCell: UITableViewCell
{
   enum CellType {
      case date, time
   }
   
   var showSeparator: Bool {
      get { return separatorView.isHidden }
      set { separatorView.isHidden = !showSeparator }
   }
   
   var record: Record = Record()
   
   @IBOutlet private weak var iconImage: UIImageView!
   @IBOutlet private weak var leftLabel: UILabel!
   @IBOutlet private weak var rightLabel: UILabel!
   @IBOutlet private weak var separatorView: UIView!
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   private func setupCell(for type: CellType)
   {
      switch type {
      case .date:
         if let date = record.begin {
            leftLabel.text = "Date"
            rightLabel.text = dateString(from: date)
         }
      case .time:
         if let date = record.begin {
            leftLabel.text = "Time"
            rightLabel.text = timeString(from: date)
         }
      }
   }
   
}
