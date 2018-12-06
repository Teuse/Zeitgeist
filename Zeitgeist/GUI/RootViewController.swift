import UIKit
import ReSwift

class RootViewController: UIViewController
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

extension RootViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
    }
}

