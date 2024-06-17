//
//  FlexpoolReducer.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import ComposableArchitecture

@Reducer
struct FlexpoolDetailReducer {
	
	@ObservableState
	struct State: Equatable {
		var id: Int
		var isLoading: Bool = false
	}
	
	enum Action {
		case completeButtonTapped
		case requestSuccess
		case delegate(Delegate)
		
		enum Delegate {
			case finished
		}
	}
	
	@Dependency(\.continuousClock) var clock
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .completeButtonTapped:
				state.isLoading = true
				return .run { send in
					try? await clock.sleep(for: .seconds(3))
					await send(.requestSuccess)
				}
			case .requestSuccess:
				state.isLoading = false
				return .send(.delegate(.finished))
				
			case .delegate:
				return .none
			}
		}
	}
}

