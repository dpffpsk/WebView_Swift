//
//  DBHelper.swift
//  webView_swift
//
//  Created by wons on 2022/11/16.
//

import Foundation
import SQLite3

struct DataModel: Codable {
    var id: Int
    var name: String
    var age: Int?
}

class DBHelper {
    
    static let shared = DBHelper()
    var db: OpaquePointer? // DB를 가르키는 포인터
    let databaseName: String = "testdb.sqlite" // DB이름("DB이름.sqlite" 형식으로 작성)
    
    init() {
        self.db = createDB()
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    // Create DB
    private func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
    
        do {
            // 저장 경로
            // 파일매니저객체 > 앱 내 디렉토리 검색 > "testdb.sqlite" 파일의 디렉토리 획득
            // 파일을 문서디렉토리(documentDirectory)에 저장하는 이유 : 일반성 (iCloud를 사용할 때도 백업 대상이 되는 디렉토리)
            let dbPath: String = try FileManager.default.url(for: .documentDirectory,
                                                            in: .userDomainMask,
                                                            appropriateFor: nil,
                                                             create: false).appendingPathComponent(self.databaseName).path
           
            if sqlite3_open(dbPath, &db) == SQLITE_OK { // 해당 파일이 없으면 만들어라
               print("Successfully created DB. Path: \(dbPath)")
               
                return db
            }
        } catch {
            print("Error while creating Database- \(error.localizedDescription)")
        }
        return nil
    }
    
    // Create Table
    func createTable(tableName: String) {
        var statement: OpaquePointer? = nil
        
        let createQuery = """
                        CREATE TABLE IF NOT EXISTS \(tableName)(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER);
                        """
            
        // sqlite3_exec() = sqlite3_prepare_v2(), sqlite3_step(), sqlite3_finalize()
        if sqlite3_prepare_v2(self.db, createQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating table has been succesfully done. db: \(String(describing: self.db))")
            } else {
                onSQLErrorPrintErrorMessage(self.db)
            }
        } else {
            onSQLErrorPrintErrorMessage(self.db)
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
        
        /*
         // sqlite3_exec()
         // parameter : pointer, sql, callback, ? , errormessage
         if sqlite3_exec(self.db, query, nil, nil, nil) != SQLITE_OK {
             let errorMessage = String(cString: sqlite3_errmsg(db))
             print("Failure while creating table: \(errorMessage)")
         }
         */
    }
    
    // Create Data
    func insertData(tableName: String, name: String, age: Int) {
        var statement: OpaquePointer? = nil
        
        let insertQuery = "INSERT INTO \(tableName) (id, name, age) values (?, ?, ?);"
        
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            // sqlite3_bind_text의 두 번째 인자는 values(?, ?, ?) 에서 몇 번째 ?에 넣을거냐를 지정
            // id는 AUTOINCREMENT
            // sqlite3_bind_text()는 마지막 인자로 메모리 관리 방식을 지정
            sqlite3_bind_text(statement, 2, name, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_int(statement, 3, Int32(age))
        } else {
            print("Sqlite3_prepare failure while inserting data")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Inserting data has been succesfully done")
        } else {
            print("Sqlite3_step failure while inserting data")
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
    }
    
    // Read Data
    func readData(tableName: String) -> [DataModel] {
        var statement: OpaquePointer? = nil
        var result: [DataModel] = [] // [DataModel]?은 값이 담기지 않음
        
        let selectQuery: String = "SELECT * FROM \(tableName);"

        if sqlite3_prepare(self.db, selectQuery, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(self.db)
            return result
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let name = String(cString: sqlite3_column_text(statement, 1))
            let age = sqlite3_column_int(statement, 2)

            result.append(DataModel(id: Int(id), name: String(name), age: Int(age)))
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
        return result
    }
    
    private func onSQLErrorPrintErrorMessage(_ db: OpaquePointer?) {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Error : \(errorMessage)")
        return
    }
    
    // Update Data
    func updateData(tableName: String, id: Int, name: String, age: Int) {
        var statement: OpaquePointer?
        
        // string은 ''로 감싸줘야 함
        let updateQuery = "UPDATE \(tableName) SET name = '\(name)', age = \(age) WHERE id == \(id)"

        if sqlite3_prepare(self.db, updateQuery, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(self.db)
            return
        }

        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(self.db)
            return
        }

        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
        print("Update has been successfully done")
    }
    
    // Delete Data
    func deleteData(tableName: String, id: Int) {
        var statement: OpaquePointer?
        
        let deleteQuery = "DELETE FROM \(tableName) WHERE id == \(id)"

        if sqlite3_prepare(self.db, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(self.db)
            return
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(self.db)
            return
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
        print("drop table has been successfully done")
    }
    
    // Drop Table
    func dropTable(tableName: String) {
        var statement: OpaquePointer?
        
        let dropQuery = "DROP TABLE \(tableName)"
        
        if sqlite3_prepare(db, dropQuery, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
        print("drop table has been successfully done")
    }
}
