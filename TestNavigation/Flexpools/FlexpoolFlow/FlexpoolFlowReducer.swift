//
//  ProfileReducer.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import ComposableArchitecture

@Reducer
struct FlexpoolFlowReducer {
	
	@Reducer(state: .equatable)
	enum Path {
		case flexpoolDetail(FlexpoolDetailReducer)
		case success(SuccessReducer)
	}
	
	@ObservableState
	struct State: Equatable {
		var path = StackState<Path.State>()
		var flexpoolList: FlexpoolListReducer.State = .init()
	}
	
	enum Action {
		case path(StackActionOf<Path>)
		case flexpoolList(FlexpoolListReducer.Action)
	}
	
	@Dependency(\.dismiss) var dismiss
	
	var body: some ReducerOf<Self> {
		Scope(state: \.flexpoolList, action: \.flexpoolList) {
			FlexpoolListReducer()
		}
		Reduce { state, action in
			switch action {
			case .flexpoolList(.itemSelected(let itemId)):
				state.path.append(.flexpoolDetail(.init(id: itemId)))
				return .none
				
			case .path(.element(id: _, action: .flexpoolDetail(.delegate(.finished)))):
				state.path.append(.success(.init()))
				return .none
				
			case .path(.element(id: _, action: .success(.closeButtonTapped))):
				return .run { _ in await dismiss() }
				
			case .path:
				return .none
				
			case .flexpoolList:
				return .none
			}
		}
		.forEach(\.path, action: \.path)
	}
}
