import UIKit
import ReSwift

class LocationTriggerViewController: UIViewController
{
   @IBOutlet weak var timeSelectionButton: UIButton!
   
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
      timeSelectionButton.titleLabel?.text = ""
        subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribe(self)
    }
   
   @IBAction func onTimeSelectionButton(_ sender: UIButton)
   {
      openTimeSelectionView()
   }
}

extension LocationTriggerViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
    }
}

extension LocationTriggerViewController
{
   private func openTimeSelectionView()
   {
      let storyboard = UIStoryboard(name: "Settings", bundle: nil)
      let controller = storyboard.instantiateViewController(withIdentifier: "TimeSelectionViewController")
      navigationController?.pushViewController(controller, animated: true)
   }
   
   private func closeTimeSelectionView() {
      
   }
}
