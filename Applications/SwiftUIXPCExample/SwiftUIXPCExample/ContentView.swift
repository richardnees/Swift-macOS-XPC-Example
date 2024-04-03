import SwiftUI
import XPCSupport

struct ContentView: View {
    @State private var content: String = "Hello world"

    private let controller = StringManipulationXPCController()

    var body: some View {
        VStack {
            TextEditor(text: $content)
            HStack {
                Button {
                    Task {
                        if let reply = await controller.stringManipulator?.uppercase(content) {
                            content = reply
                        }
                    }
                } label: {
                    Text("Uppercase")
                }
                .frame(maxWidth: .infinity)

                Button {
                    Task {
                        if let reply = await controller.stringManipulator?.lowercase(content) {
                            content = reply
                        }
                    }
                } label: {
                    Text("Lowercase")
                }
                .frame(maxWidth: .infinity)

                Button {
                    Task {
                        if let reply = await controller.stringManipulator?.capitalize(content) {
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
            let xpcErrorHandler: ((Error) -> Void) = { error in
                print(error.localizedDescription)
            }

            controller.setup(xpcErrorHandler: xpcErrorHandler)
        }
    }
}

#Preview {
    ContentView()
}
