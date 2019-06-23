import UIKit
import ReSwift

class HistoryViewController: UITableViewController
{
   var records = [Record]()
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.calendarState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return records.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryRecordCell", for: indexPath)
      let rec = records[indexPath.row]
      cell.textLabel?.text = durationString(from: rec.duration)
      return cell
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension HistoryViewController: StoreSubscriber
{
   func newState(state: CalendarState)
   {
      records.removeAll()
      records = state.records
      tableView.reloadData()
   }
}

