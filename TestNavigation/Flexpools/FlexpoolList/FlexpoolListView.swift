//
//  FlexpoolListView.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import SwiftUI
import ComposableArchitecture

struct FlexpoolListView: View {
	@Bindable var store: StoreOf<FlexpoolListReducer>
	
	var body: some View {
		VStack {
			Text("This should be a list of many items")
			Button("Select an item") {
				store.send(.itemSelected(Int.random(in: 0...10)))
			}
		}
		.navigationTitle("Flexpool List")
	}
}
