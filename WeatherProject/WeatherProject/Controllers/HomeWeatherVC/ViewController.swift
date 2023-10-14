//
//  ViewController.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import UIKit
struct ViewControllerConstants {
    static let cornerRadius = 20.0
}

/// This class loads the weather details for any input city / place
class ViewController: UIViewController {
    @IBOutlet weak var ErrorView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var searchStack: UIStackView!
    @IBOutlet weak var tempStack: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherIMage: UIImageView!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityCondition: UILabel!
    @IBOutlet weak var CcityNamr: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var searchedCity: String?
    var weatherTracker: WeatherModel?
    let viewModel = HomeViewModel(homeApiService: HomeAPIService(), locationHandler: LocationHandler())
    
    // MARK: - View Controller life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    /* To update the latest weather condition on the current
     location or searched city every time view is appeared */
    
    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }
    
    // MARK: - Private methods
        
    private func fetchWeatherData(cityName: String?){
        viewModel.fetchLocationWeather(cityName: cityName) { [weak self] data in
            switch data{
            case .success(let modelData):
                self?.ErrorView.isHidden = true
                self?.tempView.isHidden = false
                self?.weatherTracker = modelData
                self?.updateUI()
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    private func handleError(error: Error) {
        switch error{
        case APIResponseError.failed:
            self.ErrorView.isHidden = false
            self.tempView.isHidden = true
            break
        default:
            self.ErrorView.isHidden = false
            self.tempView.isHidden = true
        }
    }
    
    private func initialSetup(){
        searchStack.layer.cornerRadius = ViewControllerConstants.cornerRadius
        tempView.layer.cornerRadius = ViewControllerConstants.cornerRadius
        ErrorView.layer.cornerRadius = ViewControllerConstants.cornerRadius
        searchButton.setTitle("", for:.normal)
        tryAgainButton.layer.cornerRadius = ViewControllerConstants.cornerRadius / 2
        searchBar.delegate = self
    }
    
    private func updateUI(){
        self.CcityNamr.text = self.weatherTracker?.location?.name
        self.cityCondition.text = self.weatherTracker?.current?.condition?.text
        self.weatherIMage.image = WeatherImageHandling.getWeatherImagesBasedOn(codeForWeather: self.weatherTracker?.current?.condition?.code ?? 0)
        let temp = self.weatherTracker?.current?.temp_c ?? 0.0
        let windSpeed = self.weatherTracker?.current?.wind_kph ?? 0.0
        self.cityTemp.text = "Temp: " + "\(String(describing: temp)) " + "°C" + "\n" + "Wind: " + "\(String(describing:windSpeed)) " + "Km/h"
    }
    
    @IBAction private func tapAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WeatherDetailViewController") as WeatherDetailViewController
        vc.model = weatherTracker
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func refreshData() {
        if let searchedCity = self.searchedCity, !searchedCity.isEmpty {
            fetchWeatherData(cityName: searchedCity)
        }else{
            fetchWeatherData(cityName: nil)
        }
    }
    
    @IBAction private func tryAgain(_ sender: Any) {
        refreshData()
    }
    
    @IBAction private func searchButtonClick(_ sender: Any) {
        performSearchAction()
    }
    
    private func performSearchAction() {
        self.searchedCity = self.searchBar.text
        self.view.endEditing(true)
        if let searchedCity = self.searchedCity, !searchedCity.isEmpty {
            fetchWeatherData(cityName: searchedCity)
        }
    }
}

// MARK: - Search bar delegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearchAction()
    }
}
