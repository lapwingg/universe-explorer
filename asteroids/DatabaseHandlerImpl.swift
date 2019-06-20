//
//  DatabaseHandlerImpl.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/18/19.
//

import UIKit
import SQLite

extension UIImage: Value {
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    public class func fromDatatypeValue(_ blobValue: Blob) -> UIImage {
        return UIImage(data: Data.fromDatatypeValue(blobValue))!
    }
    public var datatypeValue: Blob {
        return self.pngData()!.datatypeValue
    }
}

internal class DatabaseHandlerImpl : DatabaseHandler {
    var db: Connection!
    var table: Table!
    let url = Expression<String>("url")
    let name = Expression<String>("name")
    let picture = Expression<Blob>("picture")
    
    func connect() {
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
    
    func insert(url eUrl: String, name eName: String, image: UIImage) {
        do {
            let blob = image.datatypeValue
            try db.run(table.insert(url <- eUrl, name <- eName, picture <- blob))
            print("INSERT")
        } catch {
            print("Sorrry I")
        }
    }

    func delete(whereUrl: String) {
        do {
            let rows = table.filter(url == whereUrl)
            try db.run(rows.delete())
            print("DELETE")
        } catch {
            print("Sorry D")
        }
    }
    
    // Stworzyc model i go zaimplikowac do Master View
    // Pozniej jakos wytransportowac to do Detail View
    // Potem ogarniecie UPDATE, DELETE w MasterView
    // Oraz DELETE w Pages i bedzie raczej gotowe :D
    func read() -> [DatabaseModel] {
        var dbModel = [DatabaseModel]()
        do {
            let rows = try db.prepare(table.select(url, name, picture))
            for r in rows {
                dbModel.append(DatabaseModel(url: r[url], name: r[name], picture: UIImage.fromDatatypeValue(r[picture])))
            }
            print("READ \(dbModel.count)")
        } catch {
            print("Sorry R")
        }
        return dbModel
    }
    
    func update(whereUrl: String, toName: String) {
        do {
            let rows = table.filter(url == whereUrl)
            try db.run(rows.update(name <- toName))
            print("UPDATE")
        } catch {
            print("Sorry U")
        }
    }
    
    func contain(url eUrl: String) -> Bool {
        do {
            let rows = try db.prepare(table.select(url).where(url == eUrl))
            for r in rows {
                print("R")
                return true
            }
        } catch {
            print("Sorry C")
        }
        return false
    }
}
