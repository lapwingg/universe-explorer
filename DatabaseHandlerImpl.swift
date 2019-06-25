//
//  Created by Czajka, Kamil
//

import UIKit
import SQLite

internal class DatabaseHandlerImpl : DatabaseHandler {
    private var db: Connection!
    private var table: Table!
    private let URL = Expression<String>("url")
    private let NAME = Expression<String>("name")
    private let PICTURE = Expression<Blob>("picture")
    
    internal func connect() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlit3")
            table = Table("favourite")
            try db.run(table.create(ifNotExists: true) { t in
                t.column(URL, primaryKey: true)
                t.column(PICTURE)
                t.column(NAME)
            })
        } catch {
            print("Unable to connect with database")
        }
    }
    
    internal func insert(url: String, name: String, image: UIImage) {
        do {
            let blob = image.datatypeValue
            try db.run(table.insert(URL <- url, NAME <- name, PICTURE <- blob))
        } catch {
            print("Unable to insert data")
        }
    }

    internal func delete(whereUrl: String) {
        do {
            let rows = table.filter(URL == whereUrl)
            try db.run(rows.delete())
        } catch {
            print("Unable to delete data")
        }
    }
    
    internal func read() -> [FavouriteTable] {
        var dbModel = [FavouriteTable]()
        do {
            let rows = try db.prepare(table.select(URL, NAME, PICTURE))
            for r in rows {
                dbModel.append(FavouriteTable(url: r[URL], name: r[NAME], picture: UIImage.fromDatatypeValue(r[PICTURE])))
            }
        } catch {
            print("Unable to read data")
        }
        return dbModel
    }
    
    internal func update(whereUrl: String, toName: String) {
        do {
            let rows = table.filter(URL == whereUrl)
            try db.run(rows.update(NAME <- toName))
        } catch {
            print("Unable to update data")
        }
    }
    
    internal func contain(url: String) -> Bool {
        do {
            let rows = try db.prepare(table.select(URL).where(URL == url))
            for _ in rows {
                return true
            }
        } catch {
            print("Unable to check containing data")
        }
        return false
    }
}
