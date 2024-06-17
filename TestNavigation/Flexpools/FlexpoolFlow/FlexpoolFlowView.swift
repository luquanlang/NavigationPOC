//
//  ProfileView.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import SwiftUI
import ComposableArchitecture

struct FlexpoolFlowView: View {
	
	@Bindable var store = Store(initialState: FlexpoolFlowReducer.State()) {
		FlexpoolFlowReducer()
	}
	
	var body: some View {
		NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
			FlexpoolListView(store: store.scope(state: \.flexpoolList, action: \.flexpoolList))
		} destination: { store in
			switch store.case {
			case let .flexpoolDetail(store):
				FlexpoolDetailView(store: store)
			case let .success(store):
				SuccessView(store: store)
			}
		}
  }
}
