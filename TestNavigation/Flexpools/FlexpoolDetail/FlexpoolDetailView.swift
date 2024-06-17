//
//  FlexpoolView.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import SwiftUI
import ComposableArchitecture

struct FlexpoolDetailView: View {
	
	var store: StoreOf<FlexpoolDetailReducer>
	var body: some View {
		VStack {
			Button("Complete") {
				store.send(.completeButtonTapped)
			}
			if store.isLoading {
				ProgressView()
			}
		}
		.navigationTitle("Flexpool \(store.id)")
	}
}
