import SwiftUI
import XPCSupport

struct ContentView: View {
    @State private var content: String = "Hello world"

    private let controller = XPCController<XPCStringManipulationService>(
        connection: NSXPCConnection(serviceName: XPCStringManipulationServiceName),
        interface: NSXPCInterface(with: XPCStringManipulationService.self)
    )

    var body: some View {
        VStack {
            TextEditor(text: $content)
            HStack {
                Button {
                    Task {
                        if let reply = await controller.service?.uppercase(content) {
                            content = reply
                        }
                    }
                } label: {
                    Text("Uppercase")
                }
                .frame(maxWidth: .infinity)

                Button {
                    Task {
                        if let reply = await controller.service?.lowercase(content) {
                            content = reply
                        }
                    }
                } label: {
                    Text("Lowercase")
                }
                .frame(maxWidth: .infinity)

                Button {
                    Task {
                        if let reply = await controller.service?.capitalize(content) {
                            content = reply
                        }
                    }
                } label: {
                    Text("Capitalized")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .navigationTitle("String Manipulation")
        .onAppear {
            let errorHandler: ((Error) -> Void) = { error in
                print(error.localizedDescription)
            }

            controller.setup(errorHandler: errorHandler)
        }
    }
}

#Preview {
    ContentView()
}
