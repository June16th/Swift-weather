//
//  HomeWeatherViewController.swift
//  Weather
//
//  Created by Savage on 7/9/21.
//

import UIKit

class HomeWeatherViewController: UITableViewController {

    var cityIDs = [ 2147714, 4163971, 2174003, 7839805]
    var groupWeatherInformation = [WeatherInformationGroupVersion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showLoadHUD("loading data")
        fetchWeatherInfoByIDs()

        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(updatePeriodically), userInfo: nil, repeats: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherInformation = groupWeatherInformation[indexPath.row]
        if let vc = storyboard?.instantiateViewController(identifier: kDetailViewControllerID) as? DetailViewController {
            vc.weatherInformation = weatherInformation
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func updatePeriodically(){
        fetchWeatherInfoByIDs()
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groupWeatherInformation.remove(at: indexPath.row)
            // Update UI
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! QueryViewController
        vc.delegate = self
    }

}

extension HomeWeatherViewController: QueryViewControllerDelegate{
    func didAddCity(_ cityID: Int) {
        cityIDs.append(cityID)
        fetchWeatherInfoByIDs()
    }
}
