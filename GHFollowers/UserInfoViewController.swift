import UIKit

protocol UserInfoListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}


class UserInfoViewController: UIViewController {

    let scrollview = UIScrollView()
    let contentView = UIView()
    
    let headerView  = UIView()
    let infoPanelOne = UIView()
    let infoPanelTwo = UIView()
    let dateLabel = GFBodyLabel(textAlign: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoListVCDelegate!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }


    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }


    func configureScrollView() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)

        scrollview.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollview)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, infoPanelOne, infoPanelTwo, dateLabel]

        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            infoPanelOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            infoPanelOne.heightAnchor.constraint(equalToConstant: itemHeight),

            infoPanelTwo.topAnchor.constraint(equalTo: infoPanelOne.bottomAnchor, constant: padding),
            infoPanelTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: infoPanelTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }

            case .failure(let error):
                self.presentGFAlertOnMainThread(title: AppStrings.unexpectedError, message: error.rawValue, buttonTitle: AppStrings.ok)
            }
        }
    }


    func configureUIElements(with user: User) {
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: GFRepoPanelViewController(user: user, delegate: self), to: self.infoPanelOne)
        self.add(childVC: GFFollowerPanelViewController(user: user, delegate: self), to: self.infoPanelTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}


extension UserInfoViewController: GFRepoItemViewControllerDelegate {

    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: AppStrings.ok)
            return
        }

        presentSafariVC(with: url)
    }
}


extension UserInfoViewController: GFFollowerItemViewControllerDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers.", buttonTitle: AppStrings.ok)
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismssVC()
    }
}
