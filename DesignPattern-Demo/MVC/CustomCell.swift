//
//  CustomCell.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import UIKit
import SnapKit
import Then

class CustomCell: UITableViewCell {
    static let identifier = "MVCCell"

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
        $0.numberOfLines = 0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
