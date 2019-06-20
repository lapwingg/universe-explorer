//
//  FavouriteTableViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/19/19.
//

import UIKit

protocol MonsterSelectionDelegate: class {
    func monsterSelected(_ newMonster: DatabaseModel?)
}

class FavouriteTableViewController: UITableViewController {
    var databaseHandler: DatabaseHandler!
    var dbModel: [DatabaseModel]?
    weak var delegate: MonsterSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(updateCell(_:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tableView.addGestureRecognizer(longPressGesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        readData()
    }
    
    @objc func updateCell(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let p = gestureRecognizer.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        let cell = self.tableView.cellForRow(at: indexPath!) as? FavouriteTableViewCell
        print("LONG")
        let alert = UIAlertController(title: "New name", message: "Current name \(String(describing: cell!.funnyName!.text!))", preferredStyle: .alert)
        alert.addTextField { textField in }
        alert.addAction(UIAlertAction(title: "OK", style: .default){ [weak alert] (_) in
            let text = alert?.textFields![0].text
            self.databaseHandler.connect()
            self.databaseHandler.update(whereUrl: self.dbModel?[indexPath?.row ?? 0].url ?? "", toName: text ?? "No name")
            cell?.funnyName.text = text
        })
        self.present(alert, animated: true)
    }
    
    private func readData() {
        databaseHandler = DatabaseHandlerImpl()
        databaseHandler.connect()
        dbModel = databaseHandler.read()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbModel?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteRows", for: indexPath) as!FavouriteTableViewCell
        cell.funnyName.text = dbModel?[indexPath.row].name
        print("DODDODOD")
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("HERE")
        delegate?.monsterSelected(dbModel?[indexPath.row])
        if let detailViewController = delegate as? FavouriteDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            databaseHandler.connect()
            databaseHandler.delete(whereUrl: dbModel![indexPath.row].url)
            dbModel?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FavouriteDetailViewController: MonsterSelectionDelegate {
    func monsterSelected(_ newMonster: DatabaseModel?) {
        dbModel = newMonster
    }
}
