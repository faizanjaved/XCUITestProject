//
//  MySqlConnector.swift
//  ClubNowUITests
//
//  Created by Syed Faizan Javed on 27/11/2019.
//

import Foundation
import MySqlSwiftNative

class MySqlConnector {
    var con = MySQL.Connection()
    lazy var dbProps : [String: AnyObject] =  DataUtil().loadJson("database")!
    lazy var addr = "127.0.0.1"
    lazy var user = "root"
    lazy var passwd = ""
    lazy var dbName = ""
    lazy var port = 3308
    
    func setPropValues() {
        addr = dbProps["addr"] as! String
        user = dbProps["user"] as! String
        passwd = dbProps["passwd"] as! String
        dbName = dbProps["dbName"] as! String
        port = (dbProps["port"] as! NSString).integerValue
    }
    
    func getConnection() -> MySQL.Connection {
        setPropValues()
        do{
            try con = MySQL.Connection.init(addr: addr, user: user, passwd: passwd, dbname: dbName, port: port)
            
            // open a new connection
            try con.open()
            
            // select the database
            try con.use(dbName)
        }
        catch (let e) {
            print(e)
        }
        return con
    }
    
    func getResultSet(_ query: String, _ con: MySQL.Connection) -> [MySQL.ResultSet]? {
        var rows: [MySQL.ResultSet]?
        
        do{
            let select_stmt = try getConnection().query(query)
            rows = try select_stmt.readAllRows()

            
        }
        catch (let e) {
            print(e)
        }
        return rows
    }
    
}
