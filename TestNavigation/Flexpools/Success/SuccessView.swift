//
//  SuccessView.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import SwiftUI
import ComposableArchitecture

struct SuccessView: View {
	
	var store: StoreOf<SuccessReducer>
	
	var body: some View {
		VStack{
			Text("CONGRATS!!!!!")
				.font(.largeTitle)
			Button("Close") {
				store.send(.closeButtonTapped)
			}
		}
		.navigationBarBackButtonHidden()
	}
}
