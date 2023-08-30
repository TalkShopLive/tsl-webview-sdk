import SwiftUI
import WebKit

@available(iOS 16, macOS 11.0, *)
public struct TSLWebview: View {
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
 
    var menuItems = [ "Travel", "Nature", "Architecture" ]
 
    public init(selectedIndex: Binding<Int>, menuItems: [String] = [ "Travel", "Nature", "Architecture" ]) {
        self._selectedIndex = selectedIndex
        self.menuItems = menuItems
    }
 
    public var body: some View {
 
        HStack {
            Spacer()
 
            Text("Dev Mode").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).fontWeight(.bold)
 
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .animation(.easeInOut, value: selectedIndex)
 
    }
}
