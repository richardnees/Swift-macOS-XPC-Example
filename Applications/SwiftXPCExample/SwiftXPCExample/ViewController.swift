import Cocoa
import XPCSupport

class ViewController: NSViewController {
    private let controller = XPCController<XPCStringManipulationService>(
        connection: NSXPCConnection(serviceName: XPCStringManipulationServiceName),
        interface: NSXPCInterface(with: XPCStringManipulationService.self)
    )

    @IBOutlet var textView: NSTextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let errorHandler: ((Error) -> Void) = { error in
            print(error.localizedDescription)
        }

        controller.setup(errorHandler: errorHandler)
    }
    
    @IBAction func uppercase(_ sender: Any?) {
        controller.service?.uppercase(textView.string) { [weak self] (reply) in
            DispatchQueue.main.async {
                self?.textView.string = reply
            }
        }
    }

    @IBAction func lowercase(_ sender: Any?) {
        controller.service?.lowercase(textView.string) { [weak self] (reply) in
            DispatchQueue.main.async {
                self?.textView.string = reply
            }
        }
    }

    @IBAction func capitalize(_ sender: Any?) {
        controller.service?.capitalize(textView.string) { [weak self] (reply) in
            DispatchQueue.main.async {
                self?.textView.string = reply
            }
        }
    }
}
