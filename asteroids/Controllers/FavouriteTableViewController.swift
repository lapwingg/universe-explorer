//
//  Created by Czajka, Kamil
//

import UIKit

internal class FavouriteTableViewController: UITableViewController {
    private var databaseHandler: DatabaseHandler!
    internal var favouriteTable: [FavouriteTable]?
    internal var delegate: FavouriteCellSelectionDelegate?
    private let CELL_HEIGHT = CGFloat(30.0)
    private let REUSE_IDENTIFIER = "favouriteRows"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupServices()
        setupGestures()
    }

    override func viewDidAppear(_ animated: Bool) {
        readData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if favouriteTable?.count != nil {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteTable?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as!FavouriteTableViewCell
        cell.titleLabel.text = favouriteTable?[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellSelected(favouriteTable?[indexPath.row])
        if let detailViewController = delegate as? FavouriteDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            databaseHandler.connect()
            databaseHandler.delete(whereUrl: favouriteTable![indexPath.row].url)
            favouriteTable?.remove(at: indexPath.row)
            delegate?.reload()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    @objc func updateCell(_ gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .changed:
            fallthrough
        case .ended:
            let p = gestureRecognizer.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: p)
            if indexPath == nil {
                return
            }
            let cell = self.tableView.cellForRow(at: indexPath!) as? FavouriteTableViewCell
            let alert = UIAlertController(title: "New name", message: "Current name \(String(describing: cell!.titleLabel!.text!))", preferredStyle: .alert)
            alert.addTextField { textField in }
            alert.addAction(UIAlertAction(title: "OK", style: .default){ [weak alert] (_) in
                let text = alert?.textFields![0].text
                self.databaseHandler.connect()
                self.databaseHandler.update(whereUrl: self.favouriteTable?[indexPath?.row ?? 0].url ?? "", toName: text ?? "No name")
                cell?.titleLabel!.text = text
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self.present(alert, animated: true)
        default:
            break
        }
        
    }
    
    private func readData() {
        databaseHandler.connect()
        favouriteTable = databaseHandler.read()
        tableView.reloadData()
    }
    
    private func setupServices() {
        databaseHandler = DatabaseHandlerImpl()
    }
    
    private func setupGestures() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(updateCell(_:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        tableView.addGestureRecognizer(longPressGesture)
    }
}
