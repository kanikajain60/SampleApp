//
//  WeatherDetailViewController.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityName: UILabel!
    var model: WeatherModel?
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
  
  // MARK: - View controller life cycle methods
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityName.text = self.model?.location?.name
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "WeatherDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailTableViewCell")
    }
}

// MARK:- Table view data source delegates

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.forecast?.forecastday?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailTableViewCell", for: indexPath) as? WeatherDetailTableViewCell else {
            return UITableViewCell()
        }

        cell.label1.text =  DateExtension.getStringDate(stringDate:self.model?.forecast?.forecastday?[indexPath.row].date ?? "")
        let tempMax = self.model?.forecast?.forecastday?[indexPath.row].day?.maxtemp_c ?? 0
        let tempMin = self.model?.forecast?.forecastday?[indexPath.row].day?.mintemp_c ?? 0
        let avgHumidity = self.model?.forecast?.forecastday?[indexPath.row].day?.avghumidity ?? 0
        let nameCondition = self.model?.forecast?.forecastday?[indexPath.row].day?.condition?.text ?? ""
        cell.label2.text = "Max Temp: " + "\(String(describing: tempMax)) " + "°C" + "\n" + "Min Temp: " + "\(String(describing: tempMin)) " + "°C"
        cell.label3.text = "Avg Humidity: " + "\(String(describing:avgHumidity))" + "\n" + "\(String(describing: nameCondition))"
        cell.weatherIcon.image = WeatherImageHandling.getWeatherImagesBasedOn(codeForWeather: self.model?.forecast?.forecastday?[indexPath.row].day?.condition?.code ?? 0)

        return cell
    }
}
