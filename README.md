# NetworkMonitor

A simple Network Monitor that monitors the internet connection from the device.

It provides realtime information about how the devices is connected to the internet, for example via Wifi, LAN or cellular.

## Example

```swift
struct ContentView: View {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        if networkMonitor.connectedToNetwork {
            Text("Connected via \(networkMonitor.typeOfNetwork)")
                .foregroundColor(.green)
        }else {
            Text("Not connected")
                .foregroundColor(.red)
        }
    }
}
```






ç
