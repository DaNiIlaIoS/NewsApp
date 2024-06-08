//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 06.06.2024.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image") ?? UIImage.add
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "06.06.24"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some title for the news"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Space, the vast and seemingly infinite expanse that exists beyond Earth's atmosphere, is a subject of endless fascination and study. Here are some intriguing aspects about space: Size and Scale: Space is unimaginably vast. The observable universe is about 93 billion light-years in diameter, and it's still expanding. A light-year, the distance light travels in one year, is about 5.88 trillion miles (9.46 trillion kilometers). Cosmic Structures: The universe contains a variety of structures, from small asteroids and comets to planets, stars, and massive galaxies. Stars cluster into galaxies, which are grouped into clusters and superclusters, forming a web-like structure known as the cosmic web. Black Holes: Black holes are regions of space where gravity is so strong that nothing, not even light, can escape. They are formed from the remnants of massive stars that have collapsed under their own gravity. Dark Matter and Dark Energy: About 85% of the universe's mass is dark matter, which does not emit, absorb, or reflect light, making it invisible and detectable only through its gravitational effects. Dark energy, a mysterious force, is driving the accelerated expansion of the universe."
        return label
    }()
    
    // MARK: - Properties
    private let edgeInset = 10
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([image, dateLabel, titleLabel, descriptionLabel])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
            make.bottom.equalToSuperview().inset(edgeInset)
        }
    }
}
