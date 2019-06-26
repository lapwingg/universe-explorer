//
//  Created by Czajka, Kamil
//

import UIKit

internal class ClosestAsteroidsViewController: UITableViewController {
    private var downloader: DataDownloadService!
    private var serializer: Serializer!
    private var asteroidsList: [AsteroidListDependsOnDate] = []
    private var activityIndicator: UIActivityIndicatorView!
    private let HEADER_HEIGHT = CGFloat(40.0)
    private let CELL_HEIGHT = CGFloat(30.0)
    private let REUSE_IDENTIFIER = "asteroidCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runActivityIndicator()
        setupServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if asteroidsList.isEmpty {
            runDownload()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return asteroidsList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroidsList[section].asteroids.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! ClosestAsteroidsViewCell
        let asteroid = getAsteroid(for: indexPath)
        cell.dataLabel.text = "\(asteroid.name)"
        if asteroid.hazardous == true {
            cell.backgroundColor = UIColor.red
        } else {
            cell.backgroundColor = UIColor.green
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return asteroidsList[section].date
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HEADER_HEIGHT
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asteroid = getAsteroid(for: indexPath)
        let alert = UIAlertController(title: asteroid.name, message: "absoluteMagnitude = \(asteroid.absoluteMagnitude)\ndiameterMax = \(asteroid.diameterMax)\nrelativeVelocity = \(asteroid.relativeVelocity)\nisHazardous = \(asteroid.hazardous)\nisSentry = \(asteroid.sentry)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true) {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    internal func runActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = tableView.center
        activityIndicator.hidesWhenStopped = true
        tableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    internal func runDownload() {
        if Reachability.isConnectedToNetwork() == false {
            let alert = UIAlertController(title: "No internet Connection", message: "Check internet connection and run application again", preferredStyle: .alert)
            present(alert, animated: true)
        } else {
            _ = downloader.runDownload(date: getTodayDate(), queryType: .closestAsteroids) { [unowned self] data in
                self.serializer.decode(ofType: ClosestAsteroidsRoot.self, data: data) { closestAsteroids in
                    self.fetchData(from: closestAsteroids)
                    self.sortedByDate(asteroids: self.asteroidsList)
                    self.tableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    private func fetchData(from closestAsteroids: ClosestAsteroidsRoot) {
        for cA in closestAsteroids.nearEarthObjects {
            self.asteroidsList.append(AsteroidListDependsOnDate(date: cA.key))
            for a in cA.value {
                self.asteroidsList.last?.asteroids.append(Asteroid(name: a.name, diameterMax: a.estimatedDiameter.kilometers.estimatedDiameterMax, hazardous: a.isPotentiallyHazardousAsteroid, sentry: a.isSentryObject, absoluteMagnitude: a.absoluteMagnitudeH, relativeVelocity: a.closeApproachData[0].relativeVelocity.kilometersPerHour))
            }
        }
    }
    
    private func sortedByDate(asteroids: [AsteroidListDependsOnDate]) {
        do {
            self.asteroidsList = try asteroids.sorted(by: {(a1: AsteroidListDependsOnDate, a2: AsteroidListDependsOnDate) throws -> Bool in return a1.date < a2.date })
        } catch {
            return
        }
    }
    
    private func setupServices() {
        downloader = NASADownloadService()
        serializer = JSONSerializer()
    }
    
    fileprivate func getAsteroid(for indexPath: IndexPath) -> Asteroid {
        return asteroidsList[indexPath.section].asteroids[indexPath.row]
    }
    
    fileprivate func getTodayDate() -> Date {
        return Date()
    }
}
