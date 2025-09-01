//
//  Task.swift
//  ClazziFirebase
//
//  Created by Admin on 9/1/25.
//

import Foundation

extension Task where Success == Never,Failure == Never {
    //초 단위로 Task.sleep 오버로딩
    static func sleep(seconds: UInt64) async throws {
        try await Task.sleep(nanoseconds: seconds * 1_000_000_000)
    }
}
