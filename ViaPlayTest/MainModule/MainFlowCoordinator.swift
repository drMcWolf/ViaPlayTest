import UIKit

public protocol MainFlowCoordinatorProtocol {}

final class MainFlowCoordinator: MainFlowCoordinatorProtocol {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    private let mainScreenAssembly: MainAssemblyProtocol
    
    // MARK: - Public Methods

    init(
        navigationController: UINavigationController,
        mainScreenAssembly: MainAssemblyProtocol
    ) {
        self.navigationController = navigationController
        self.mainScreenAssembly = mainScreenAssembly
    }

    public func start() {
        let mainViewController = mainScreenAssembly.assemble(output: self)
        navigationController.viewControllers = [mainViewController]
    }
    
}


// MARK: - SomeFeatureModuleOutput

extension MainFlowCoordinator: MainModuleOutput {
    public func handle(output: Main.Output) {
        switch output {}
    }
}
