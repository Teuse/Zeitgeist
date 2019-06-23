import Foundation
import UIKit

class RecordCell: UITableViewCell
{
   @IBOutlet private weak var iconImageView: UIImageView!
   @IBOutlet private weak var leftLabel: UILabel!
   @IBOutlet private weak var rightLabel: UILabel!
   @IBOutlet private weak var separator: UIView!
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   var icon: UIImage? {
      didSet { iconImageView?.image = icon }
   }
   
   var name: String = "" {
      didSet { leftLabel?.text = name }
   }
   
   var value: String = "" {
      didSet { rightLabel?.text = value }
   }
   
   var isSeparatorHidden: Bool = false {
      didSet { separator?.isHidden = isSeparatorHidden }
   }
}
