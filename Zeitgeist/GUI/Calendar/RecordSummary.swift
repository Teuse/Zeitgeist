import Foundation
import UIKit

class RecordSumamry: UIViewController
{
   @IBOutlet private weak var recordTableContainer: UIView!
   
   override func viewDidLoad()
   {
      let vc = createRecordViewController()
      recordTableContainer.addSubview(vc.view)
   }
   
   private func createRecordViewController() -> RecordTableView
   {
      let sb = UIStoryboard(name: "RecordTableView", bundle: nil)
      let vc = sb.instantiateInitialViewController() as! RecordTableView
      vc.cellTypes = [[.date]]
      return vc
   }
}
