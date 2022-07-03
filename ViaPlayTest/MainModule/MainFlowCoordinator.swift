import UIKit

public protocol MainFlowCoordinatorProtocol {}

final class MainFlowCoordinator: MainFlowCoordinatorProtocol {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    private let mainScreenAssembly: MainAssemblyProtocol
    private let sectionDetailsAssembly: SectionDetailsAssemblyProtocol
    
    // MARK: - Public Methods

    init(
        navigationController: UINavigationController,
        mainScreenAssembly: MainAssemblyProtocol,
        sectionDetailsAssembly: SectionDetailsAssemblyProtocol
    ) {
        self.navigationController = navigationController
        self.mainScreenAssembly = mainScreenAssembly
        self.sectionDetailsAssembly = sectionDetailsAssembly
    }

    public func start() {
        let mainViewController = mainScreenAssembly.assemble(output: self)
        navigationController.viewControllers = [mainViewController]
    }
    
}

private extension MainFlowCoordinator {
    func showSectiondDetails(section: VPSection) {
        let sectionDetailsViewController = sectionDetailsAssembly.assembly(section: section)
        navigationController.pushViewController(sectionDetailsViewController, animated: true)
    }
}


// MARK: - SomeFeatureModuleOutput

extension MainFlowCoordinator: MainModuleOutput {
    public func handle(output: Main.Output) {
        switch output {
        case let .onSectionDetails(section):
            showSectiondDetails(section: section)
        }
    }
}
