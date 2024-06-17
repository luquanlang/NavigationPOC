//
//  ProfileView.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
	
	@Bindable var store = Store(initialState: ProfileReducer.State()) {
		ProfileReducer()
			._printChanges()
	}
	
	var body: some View {
		NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
			VStack {
				Text("Some introductory text")
				Button("Next") {
					store.send(.nextButtonTapped)
				}
				Button("Standalone flow") {
					store.send(.standaloneFlowButtonTapped)
				}
			}
			.navigationTitle("Profile")
			.sheet(
				item: $store.scope(state: \.destination?.flexpoolFlow, action: \.destination.flexpoolFlow)
			) { store in
				FlexpoolFlowView(store: store)
			}
		} destination: { store in
			switch store.case {
			case let .flexpoolList(store):
				FlexpoolListView(store: store)
			case let .flexpoolDetail(store):
				FlexpoolDetailView(store: store)
			case let .success(store):
				SuccessView(store: store)
			}
		}
  }
}
