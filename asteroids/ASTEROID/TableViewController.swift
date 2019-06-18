//
//  TableViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class TableViewController: UITableViewController {
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var closestAsteroids: ClosestAsteroidsRoot?
    private var prepareData: [PrepareData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if prepareData.isEmpty {
            runDownload()
        }
    }

    func runDownload() {
        _ = downloader?.runDownload(date: Date(), queryType: .closestAsteroids) { [unowned self] data in
            self.serializer?.decode(ofType: ClosestAsteroidsRoot.self, data: data) { closestAsteroids in
                self.closestAsteroids = closestAsteroids
                for p in closestAsteroids.nearEarthObjects {
                    self.prepareData.append(PrepareData(date: p.key))
                    for x in p.value {
                        self.prepareData.last?.data.append(DataA(name: x.name, diameterMax: x.estimatedDiameter.kilometers.estimatedDiameterMax, hazardous: x.isPotentiallyHazardousAsteroid, sentry: x.isSentryObject, absoluteMagnitude: x.absoluteMagnitudeH, relativeVelocity: x.closeApproachData[0].relativeVelocity.kilometersPerHour))
                    }
                    do {
                        self.prepareData = try self.prepareData.sorted(by: {(p1: PrepareData, p2: PrepareData) throws -> Bool in return p1.date < p2.date })
                    } catch {
                        return
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return prepareData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return prepareData[section].data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidCell", for: indexPath) as! ClosestAsteroidsViewCell
        let data = asteroid(for: indexPath)
        cell.dataLabel.text = "\(data.name)"
        if data.hazardous == true {
            cell.backgroundColor = UIColor.red
        } else {
            cell.backgroundColor = UIColor.green
        }
        return cell
    }
    
    func asteroid(for indexPath: IndexPath) -> DataA {
        return prepareData[indexPath.section].data[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return prepareData[section].date
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = prepareData[indexPath.section].data[indexPath.row]
        let alert = UIAlertController(title: data.name, message: "absoluteMagnitude = \(data.absoluteMagnitude)\ndiameterMax = \(data.diameterMax)\nrelativeVelocity = \(data.relativeVelocity)\nisHazardous = \(data.hazardous)\nisSentry = \(data.sentry)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true) {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
