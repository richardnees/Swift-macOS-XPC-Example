import Cocoa
import XPCSupport

class ViewController: NSViewController {
    private let controller = StringManipulationXPCController()

    @IBOutlet var textView: NSTextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let xpcErrorHandler: ((Error) -> Void) = { error in
            print(error.localizedDescription)
        }

        controller.setup(xpcErrorHandler: xpcErrorHandler)
    }
    
    @IBAction func uppercase(_ sender: Any?) {
        controller.stringManipulator?.uppercase(textView.string) { [weak self] (reply) in
            DispatchQueue.main.async {
                self?.textView.string = reply
            }
        }
    }

    @IBAction func lowercase(_ sender: Any?) {
        controller.stringManipulator?.lowercase(textView.string) { [weak self] (reply) in
            DispatchQueue.main.async {
                self?.textView.string = reply
            }
        }
    }

    @IBAction func capitalize(_ sender: Any?) {
        controller.stringManipulator?.capitalize(textView.string) { [weak self] (reply) in
            DispatchQueue.main.async {
                self?.textView.string = reply
            }
        }
    }
}
