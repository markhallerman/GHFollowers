import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}


class GFUserInfoItemView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlign: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlign: .center, fontSize: 14)


    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }


    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = Images.SFSymbols.repos
            titleLabel.text = AppStrings.repos
        case .gists:
            symbolImageView.image = Images.SFSymbols.gists
            titleLabel.text = AppStrings.gists
        case .followers:
            symbolImageView.image = Images.SFSymbols.followers
            titleLabel.text = AppStrings.followers
        case .following:
            symbolImageView.image = Images.SFSymbols.following
            titleLabel.text = AppStrings.following
        }

        countLabel.text = String(count)
    }
}
