import Foundation

protocol GFFollowerItemViewControllerDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerPanelViewController: GFUserInfoPanelViewController {

    weak var delegate: GFFollowerItemViewControllerDelegate!


    init(user: User, delegate: GFFollowerItemViewControllerDelegate) {
        super.init(user: user)

        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }


    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }


    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
