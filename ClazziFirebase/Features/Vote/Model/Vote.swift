//
//  Vote.swift
//  Clazzi
//
//  Created by Admin on 8/27/25.
//
import Foundation

import FirebaseFirestore


struct Vote :Identifiable, Codable {
    @DocumentID var id: String? //@DocumentID역할: 투표 객체 가져올때 documnetId를 vote의 id로 만들어줌
    var title: String
    var createdBy: String
    var createdAt: Date
    var options: [VoteOption]
    
    init(title:String, createdBy:String, options:[VoteOption]=[]){
        self.id = nil
        self.title = title
        self.createdBy = createdBy
        self.createdAt = Date()
        self.options = options
    }
}


struct VoteOption :Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var voters: [String] = [] //여기에 투표자 ID 저장
    
    init(name: String){
        self.id = nil
        self.name = name
    }
}
