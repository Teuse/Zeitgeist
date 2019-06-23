import Foundation
import UIKit

class RecordTextCell: RecordCell
{
   @IBOutlet private weak var textView: UITextView!
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   var notes: String = "" {
      didSet { textView?.text = notes }
   }
}
