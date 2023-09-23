import SwiftUI
import Network

@available(iOS 13.0, *)
public class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    @Published public var connectedToNetwork = true
    @Published private var isExpensive = true
    @Published private var isConstrained = true
    @Published private var connectionType = NWInterface.InterfaceType.other
    
    public var typeOfNetwork: String {
        switch connectionType {
        case .other:
            return ""
        case .wifi:
            return "WIFI"
        case .cellular:
            return "Cellular"
        case .wiredEthernet:
            return "Ethernet"
        case .loopback:
            return "loopback"
        @unknown default:
            return ""
        }
    }
    
    public init() {
        monitor.pathUpdateHandler = { path in
            Task { @MainActor in
                self.connectedToNetwork = path.status == .satisfied
                self.isExpensive = path.isExpensive
                self.isConstrained = path.isConstrained
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            }
        }
        monitor.start(queue: queue)
    }
}
