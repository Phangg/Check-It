//
//  Injected.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

@propertyWrapper
struct Injected<T> {
    private let container: AppContainer
    private var type: T.Type
    
    var wrappedValue: T {
        container.resolve(type)
    }
    
    init(
        _ type: T.Type,
        container: AppContainer = AppContainer.shared
    ) {
        self.type = type
        self.container = container
    }
}
