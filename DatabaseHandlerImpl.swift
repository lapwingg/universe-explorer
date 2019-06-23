//
//  DatabaseHandlerImpl.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/18/19.
//

import UIKit
import SQLite

internal class DatabaseHandlerImpl : DatabaseHandler {
    private var db: Connection!
    private var table: Table!
    private let url = Expression<String>("url")
    private let name = Expression<String>("name")
    private let picture = Expression<Blob>("picture")
    
    internal func connect() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlit3")
            table = Table("favourite")
            try db.run(table.create(ifNotExists: true) { t in
                t.column(url, primaryKey: true)
                t.column(picture)
                t.column(name)
            })
            print("CONNECT")
        } catch {
            print("Sorry")
        }
    }
    
    internal func insert(url eUrl: String, name eName: String, image: UIImage) {
        do {
            let blob = image.datatypeValue
            try db.run(table.insert(url <- eUrl, name <- eName, picture <- blob))
            print("INSERT")
        } catch {
            print("Sorrry I")
        }
    }

    internal func delete(whereUrl: String) {
        do {
            let rows = table.filter(url == whereUrl)
            try db.run(rows.delete())
            print("DELETE")
        } catch {
            print("Sorry D")
        }
    }
    
    internal func read() -> [FavouriteTable] {
        var dbModel = [FavouriteTable]()
        do {
            let rows = try db.prepare(table.select(url, name, picture))
            for r in rows {
                dbModel.append(FavouriteTable(url: r[url], name: r[name], picture: UIImage.fromDatatypeValue(r[picture])))
            }
            print("READ \(dbModel.count)")
        } catch {
            print("Sorry R")
        }
        return dbModel
    }
    
    internal func update(whereUrl: String, toName: String) {
        do {
            let rows = table.filter(url == whereUrl)
            try db.run(rows.update(name <- toName))
            print("UPDATE")
        } catch {
            print("Sorry U")
        }
    }
    
    internal func contain(url eUrl: String) -> Bool {
        do {
            let rows = try db.prepare(table.select(url).where(url == eUrl))
            for _ in rows {
                print("R")
                return true
            }
        } catch {
            print("Sorry C")
        }
        return false
    }
}
