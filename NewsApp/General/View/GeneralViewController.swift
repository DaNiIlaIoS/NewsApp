//
//  GeneralViewController.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 04.06.2024.
//

import UIKit
import SnapKit

final class GeneralViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 15) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        //      layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - searchBar.frame.height), collectionViewLayout: layout)
        collectionView.addGestureRecognizer(recognize)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    private var viewModel: NewsListViewModelProtocol
    private var isKeyboardVisible = false
    private lazy var recognize = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    
    // MARK: - Life Cycle
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        recognize.cancelsTouchesInView = false
        
        viewModel.loadData(searchText: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterForKeyboardNotification()
    }
    
    // MARK: - Private Methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.reloadCell = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
        viewModel.showError = { [weak self] error in
            self?.showAlert(message: error)
            print(error)
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension GeneralViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell else { return UICollectionViewCell() }
        
        cell.set(article: article)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GeneralViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return }
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.sections[indexPath.section].items.count - 15) {
            debugPrint(#function)
            viewModel.loadData(searchText: searchBar.text)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

// MARK: - UISearchBarDelegate
extension GeneralViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        viewModel.loadData(searchText: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.loadData(searchText: nil)
        }
    }
}

// MARK: - Keyboard Handling
extension GeneralViewController {
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow() {
        isKeyboardVisible = true
        recognize.cancelsTouchesInView = true
        print("Клавиатура видна")
    }
    
    @objc func keyboardWillHide() {
        isKeyboardVisible = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.recognize.cancelsTouchesInView = false
        }
        print("Клавиатура скрыта")
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
