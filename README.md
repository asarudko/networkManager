## Setup

- In Xcode select File > Add Packages.
- Enter this project's URL: [https://github.com/rrt5n/networkManager](https://github.com/rrt5n/networkManager)

## Usage
### Create App Environment
```Swift
extension AppEnvironment {

 static let production = AppEnvironment(
    name: "Production",
    baseURL: URL(string: "https://myURL.com")!,
    session: {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "APIKey": "production-key"
        ]
        return URLSession(configuration: configuration)
    }()
 )

 #if DEBUG
  static let testing = AppEnvironment(
    name: "Testing",
    baseURL: URL(string: "https://127.0.0.1")!,
    session: {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.httpAdditionalHeaders = [
            "APIKey": "test-key"
        ]
        return URLSession(configuration: configuration)
    }()
 )
 #endif
}
 ```
### Create your endpoints
```Swift
extension Endpoint where T == [Appointment] {
    static let appointments = Endpoint(path: "appointments", type: [Appointment].self)
}

extension Endpoint where T == [Doctor] {
    static let doctors = Endpoint(path: "doctors", type: [Doctor].self)
}
 ```
### Fetch data
```Swift
let networkManager = NetworkManager (environment: .testing)
let appointments = try await networkManager.fetch(.appointments)
 ```
### [Optional] Add Network Manager to your SwiftUI Environment
#### Create NetworkManager EnvironmentKey
```Swift
struct NetworkManagerKey: EnvironmentKey {
    static var defaultValue = NetworkManager(environment: .testing)
}

extension EnvironmentValues {
    var networkManager: NetworkManager {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
}
 ```
#### Declare in SwiftUI
```Swift
@main
struct YourApp: App {
  @State var networkManager = NetworkManager (environment: .testing)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.networkManager, networkManager)
        }
    }
}
 ```
#### Use in SwiftUI View
```Swift
struct ContentView: View {
 @Environment(\.networkManager) var networkManager
    var body: some View {
        SomeView()
    }
}
 ```
### License

[MIT](https://choosealicense.com/licenses/mit/)
