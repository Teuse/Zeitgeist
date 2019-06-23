import Foundation
import UIKit
import ReSwift

class RecordTableView: UIViewController
{
   enum CellType
   {
      case date, started, pause, duration, timeRange, overtime
      case project, notes
   }
   
   var cellTypes: [[CellType]] = [[]] {
      didSet { tableView?.reloadData() }
   }
   
   private var record = Record() {
      didSet { tableView?.reloadData() }
   }
   
   private let recordCellId = "RecordCellId"
   private let recordTextCellId = "RecordTextCellId"
   
   @IBOutlet private weak var tableView: UITableView!
   
   // ----------------------------------------------------------------------------
   
   override func viewDidLoad()
   {
      tableView.delegate = self
      tableView.dataSource = self
      
      subscribe(self) { subcription in
         subcription.select { state in state.calendarState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension RecordTableView: StoreSubscriber
{
   func newState(state: CalendarState)
   {
      if let rec = state.selectedRecord {
         record = rec
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension RecordTableView: UITableViewDelegate, UITableViewDataSource
{
//   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//   {
//   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      print("\(indexPath)")
      let type = cellTypes[indexPath.section][indexPath.row]
      let cell = getCell(for: type, at: indexPath)
      cell.isSeparatorHidden = cellTypes[indexPath.section].count == indexPath.row + 1
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
   {
      let type = cellTypes[indexPath.section][indexPath.row]
      if type == .notes {
         return 150
      }
      return 44
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return cellTypes.count
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return cellTypes[section].count
   }
}

extension RecordTableView
{
   private func getCell(for type: CellType, at indexPath: IndexPath) -> RecordCell
   {
      switch type {
      case .date:     return createDateCell(for: indexPath)
      case .started:  return createStartedCell(for: indexPath)
      case .pause:    return createPauseCell(for: indexPath)
      case .duration: return createDurationCell(for: indexPath)
      case .timeRange:return createTimeRangeCell(for: indexPath)
      case .overtime: return createOvertimeCell(for: indexPath)
      case .project:  return createProjectCell(for: indexPath)
      case .notes:    return createNotesCell(for: indexPath)
      }
   }
   
   private func createDateCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Date"
//      let date = record.begin
//      cell.value = date != nil ? dateString(from: date!) : "-"
      return cell
   }
   
   private func createStartedCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Started"
//      let date = record.begin
//      cell.value = date != nil ? timeString(from: date!) : "-"
      return cell
   }
   
   private func createPauseCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Pause"
      cell.value = "???"
      return cell
   }
   
   private func createDurationCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Duration"
      cell.value = "???"
      return cell
   }
   
   private func createTimeRangeCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Duration"
//      if let date = record.begin {
//         cell.value = timeString(from: date)
//      }
//      if let date = record.end {
//        cell.value = cell.value + " - " + timeString(from: date)
//      }
      return cell
   }
   
   private func createOvertimeCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Duration"
//      if let date = record.begin {
//         cell.value = timeString(from: date)
//      }
//      if let date = record.end {
//         cell.value = cell.value + " - " + timeString(from: date)
//      }
      return cell
   }
   
   private func createProjectCell(for indexPath: IndexPath) -> RecordCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: recordCellId, for: indexPath) as! RecordCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Duration"
//      if let date = record.begin {
//         cell.value = timeString(from: date)
//      }
//      if let date = record.end {
//         cell.value = cell.value + " - " + timeString(from: date)
//      }
      return cell
   }
   
   private func createNotesCell(for indexPath: IndexPath) -> RecordTextCell
   {
      let id = recordTextCellId
      let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! RecordTextCell
      cell.icon = UIImage(named: "IconDate")
      cell.name = "Duration"
      cell.value = ""
      cell.notes = ""
      return cell
   }
}
