//
//  CreateVoteView.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI

struct VoteEditorView: View {
    //뒤로가기 (모달 바텀시트) 닫기
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var options: [String]
    
    //투표 목록 화면에서 전달해줄 콜백 메서드 함수를 받아서 원하는 때에 실행
    var onSave: (Vote) -> Void //Vote라는 매개변수 받고 반환은 Void
    
    private var vote: Vote? = nil
    /**
     생성자
     투표 생성으로 들어왔을 때는 투표 없어도 되기 때문에 nil
     CreateVoteView()만 호출하면 투표 생성 모드
     CreateVoteView(vote: someVote)처럼 넘겨주면 투표 수정 모드
     저장완료시 실행할 콜백함수
     */
    init(vote: Vote? = nil, onSave: @escaping(Vote)-> Void){
        self.vote = vote
        self.onSave = onSave
        // 수정일 경우 초기값 설정
        self.title = vote?.title ?? ""
        self.options = vote?.options.map { $0.name } ?? ["", ""]
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    VStack(alignment: .leading){
                        TextField("투표 제목", text: $title)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.bottom, 32)
                        HStack{
                            Text("투표 항목")
                                .font(.headline)
                            Spacer()
                            Button("항목 추가"){
                                options.append("")
                            }
                        }
                    
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        ForEach(options.indices, id: \.self){ index in
                            TextField("항목 \(index+1)", text: $options[index])
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    
                        
                        Spacer()
                        
                        
                        
                    }
                }
                .navigationBarTitle(Text(vote == nil ? "투표 생성 화면" : "투표 수정 화면"))
                
                //생성,수정하기 버튼
                Button(action: {
                    if let vote = vote { //투표 수정
                        vote.title = title
                        vote.options = options.map{VoteOption(name: $0) }
                        onSave(vote)
                    } else {  //투표 삭제
                        let newVote = Vote(title: title, options:options.map{VoteOption(name: $0)})
                        onSave(newVote)
                    }
                    dismiss()
                    
                }){
                    Text(vote == nil ? "생성하기": "수정하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview("투표 생성") {
    VoteEditorView() { _ in }
}

#Preview("투표 수정") {
    // 샘플 투표 생성
    let sampleVote = Vote(title: "샘플 투표", options: [
        VoteOption(name: "옵션 1"),
        VoteOption(name: "옵션 2")
    ])
    // 뷰에 샘플 투표 전달
    VoteEditorView(vote: sampleVote) { _ in }
}
