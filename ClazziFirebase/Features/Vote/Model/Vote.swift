//
//  Vote.swift
//  Clazzi
//
//  Created by Admin on 8/27/25.
//
import Foundation

import SwiftData

//스위프트 데이터에서 사용할 수 있는 모델로 바꿔주는 어트리뷰트
@Model
class Vote :Identifiable{
    var id = UUID()
    var title: String
    @Relationship(deleteRule: .cascade)
    var options: [VoteOption]
    
    init(title:String, options:[VoteOption]){
        self.id = UUID()
        self.title = title
        self.options = options
    }
}

@Model
class VoteOption {
    var name: String
    var voters: [UUID] = [] //여기에 투표자 ID 저장
    
    init(name: String){
        self.name = name
    }
    //해당 투표 항목에 투표자가 몇 명 있는지: 투표수
    var votes: Int{
        voters.count
    }
    
    //로그인한 유저가 이미 투표했는지, 투표 했다면 투표 못하도록 
    func hasVoted(userId: UUID) -> Bool{
        voters.contains(userId)
    }
}
