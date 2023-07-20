//
//  GFRepoPanelVC.swift
//  GHFollowers
//
//  Created by Mark on 8/22/21.
//
import Foundation

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoPanelVC: GFUserInfoPanelVC {

    weak var delegate: GFRepoItemVCDelegate!


    init(user: User, delegate: GFRepoItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }


    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
