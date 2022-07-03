import UIKit

public final class SectionsListView: UIView {
    private struct Constants {
        static let reuseId = String(describing: UITableViewCell.self)
    }
    // MARK: - Public Properties

    let selectedInndex: Observable<Int?> = .init(nil)
    
    // MARK: - Subview Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseId)
        return tableView
    }()
    
    
    // MARK: - Private Properties
    private var viewModel: ViewModel?
    
    // MARK: - UIView

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func commonInit() {
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - Configurable

extension SectionsListView: Configurable {
    struct ViewModel {
        let title: String
        let cellViewModels: [UITableViewCell.ViewModel]
    }
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SectionsListView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        if let cellViewModel = viewModel?.cellViewModels[indexPath.row] {
            cell.configure(with: cellViewModel)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedInndex.value = indexPath.row
    }
}

extension UITableViewCell: Configurable {
    struct ViewModel {
        let title: String
    }
    func configure(with viewModel: ViewModel) {
        textLabel?.text = viewModel.title
    }
}
