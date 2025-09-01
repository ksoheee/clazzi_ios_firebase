//
//  VoteListView.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI
import FirebaseAuth

struct VoteListView: View {
    @EnvironmentObject var session: UserSession
    @StateObject private var voteViewModel = VoteViewModel()
    
    // 투표 수정 관련
    @State private var isPresentingEdit = false
    @State private var voteToEdit: Vote? = nil
    
    //투표 삭제 관련
    @State private var showDeleteAlert = false
    @State private var voteToDelete: Vote? = nil

    var body: some View {
        NavigationStack {
            ZStack { //겹쳐 쌓기 위해(IScrollView 위에 Button을 겹쳐서 올려놓을 수 있음)
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(voteViewModel.votes) { vote in //votes의 인덱스를 가져오기 위해 indices
//                            let vote = votes[index]
                            NavigationLink(destination: VoteView(vote:vote)){
                                VoteCardView(vote: vote) {
                                    voteToDelete = vote
                                    showDeleteAlert = true
                                    //votes.remove(at: index) //바로 삭제
                                } onEdit: {
                                    voteToEdit = vote
                                    isPresentingEdit = true
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle(Text("투표 목록"))
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    //화면 이동 방법1: 툴바 네이게이션 링크
                    NavigationLink(destination: VoteEditorView{ newVote in
                        voteViewModel.createVote(newVote)
                    }){
                        Image(systemName: "plus") //버튼을 누르면 NavigationStack을 통해 이동
                    }
                    //화면 이동 방법 2: 상태를 이용한 이동 방법
//                    Button(action:{
//                        isPresentingCreate = true
//                    }){
//                        Image(systemName: "plus")
//                    }
                }
                //마이페이지
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: MyPageView()){
                        Image(systemName: "person")
                    }
                   
                }
            }
            //수정화면 띄우기
            .navigationDestination(isPresented: $isPresentingEdit){
                if let vote = voteToEdit{
                    VoteEditorView(vote: vote) { updatedVote in
                        voteViewModel.updateVote(updatedVote)
                        
                    }
                }
                
            }

            
            //삭제 alert
            .alert("투표를 삭제하시겠습니까?", isPresented: $showDeleteAlert){ //showDeleteAlert==true가 되면 경고창
                Button("삭제", role: .destructive){
                    if let vote = voteToDelete {
                        voteViewModel.deleteVote(vote)
                        voteToDelete = nil
                    }
                }
                Button("취소", role: .cancel){
                    voteToDelete = nil //취소 시 상태 초기화
                }
            } message:{
                if let target = voteToDelete {
                    Text("'\(target.title)' 투표가 삭제됩니다.")
                }
            }
            
            
        }
    }
}//

struct VoteCardView: View {
    let vote: Vote
    let onDelete: () -> Void //콜백함수, 클로저
    let onEdit: () -> Void
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(vote.title)
                    .font(.title2)
                    .foregroundColor(.white)
                Text("투표 항목 보기")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action:{
                onEdit()
            }){
                Image(systemName: "pencil")
                    .foregroundStyle(.white)
            }
            Button(action:{
                onDelete()
            }){
                Image(systemName: "trash")
                    .foregroundStyle(.white)
            }
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 4)
    }
}

