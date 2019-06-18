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
    let picture = Expression<Blob>("picture")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    
    func connect() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlit3")
            table = Table("favourite")
            try db.run(table.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(picture)
                t.column(name)
            })
            print("CONNECT")
        } catch {
            print("Sorry")
        }
    }
    
    func insert(image: UIImage) {
        do {
            let blob = image.datatypeValue
            try db.run(table.insert(picture <- blob))
            print("INSERT")
        } catch {
            print("Sorrry I")
        }
    }

    func delete() {
        do {
            let rows = table.filter(name == "ABC")
            try db.run(rows.delete())
            print("DELETE")
        } catch {
            print("Sorry D")
        }
    }
    
    func read() {
        do {
            let rows = try db.prepare(table.select(picture))
            var i = 1
            for _ in rows {
                print(i)
                i = i + 1
            }
            print("READ")
        } catch {
            print("Sorry R")
        }
    }
    
    func update() {
        do {
            let rows = table.filter(name == "ABC")
            try db.run(rows.update(name <- "NEXT"))
            print("UPDATE")
        } catch {
            print("Sorry U")
        }
    }
}
