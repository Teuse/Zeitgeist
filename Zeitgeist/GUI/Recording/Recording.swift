import Foundation
import UIKit
import ReSwift

class Recording: UIViewController
{
   private var data1 = ["Date", "Time", "Duration", "Overtime"]
   private var data2 = [""]
   
   @IBOutlet private weak var tableView: UITableView!
   
   // ----------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
      
      tableView.delegate = self
      tableView.dataSource = self
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension Recording: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension Recording: UITableViewDelegate, UITableViewDataSource
{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCellId") as! RecordingCell
      cell.record = Record()
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
   }
}
