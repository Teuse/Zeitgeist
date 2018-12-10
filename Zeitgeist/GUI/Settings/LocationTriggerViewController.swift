import UIKit
import ReSwift

class LocationTriggerViewController: UIViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribe(self)
    }
}

extension LocationTriggerViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
    }
}
