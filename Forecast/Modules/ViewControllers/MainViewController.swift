import UIKit
import Swinject

final class MainViewController: UIViewController, MainViewProtocol {

    // MARK: - MainViewProtocol Properties
    var presenter: MainPresenterProtocol!
    
    // MARK: - Private Properties
    private var citiesCollectionView: UICollectionView!
    
    // MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }

    // MARK: - MainViewProtocol Methods
    func configureView() {
        view.backgroundColor = .white
        configureCollectionView()
    }
    
    func updateView() {
        guard let citiesCollectionView = citiesCollectionView else { return }
        
        if presenter.cities.isEmpty {
            citiesCollectionView.backgroundView = BackgroundView()
        } else {
            citiesCollectionView.backgroundView = nil
        }
        citiesCollectionView.reloadData()
    }
}
    
    // MARK: - Private Methods
private extension MainViewController {
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        citiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        citiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        citiesCollectionView.backgroundColor = .black
        citiesCollectionView.register(MainCell.self,
                                        forCellWithReuseIdentifier: MainCell.identifier)
        citiesCollectionView.isPagingEnabled = true
        
        citiesCollectionView.backgroundView = BackgroundView()
        
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
        
        autolayoutSetup()
    }
    
    func autolayoutSetup() {
        guard let citiesCollectionView = citiesCollectionView else { return }
        
        view.addSubview(citiesCollectionView)
        
        NSLayoutConstraint.activate([
            citiesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citiesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            citiesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        let searchButton = UIBarButtonItem(image: .searchIcon,
                                         style: .plain,
                                         target: self,
                                         action: #selector(searchButtonDidTap))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc
    func searchButtonDidTap() {
        presenter.pushSearchScreen()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let city = presenter.cities[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        cell.configure(city: city)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

