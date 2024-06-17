//
//  ProfileReducer.swift
//  TestNavigation
//
//  Created by Alejandro Luján López on 14/6/24.
//

import ComposableArchitecture

@Reducer
struct ProfileReducer {
	
	@Reducer(state: .equatable)
	enum Destination {
		case flexpoolFlow(FlexpoolFlowReducer)
	}
	
	@Reducer(state: .equatable)
	enum Path {
		case flexpoolList(FlexpoolListReducer)
		case flexpoolDetail(FlexpoolDetailReducer)
		case success(SuccessReducer)
	}
	
	@ObservableState
	struct State: Equatable {
		var path = StackState<Path.State>()
		@Presents var destination: Destination.State?
	}
	
	enum Action {
		case destination(PresentationAction<Destination.Action>)
		case path(StackActionOf<Path>)
		case nextButtonTapped
		case standaloneFlowButtonTapped
	}
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .nextButtonTapped:
				state.path.append(
					.flexpoolList(
						FlexpoolListReducer.State()
					)
				)
				return .none
				
			case .standaloneFlowButtonTapped:
				state.destination = .flexpoolFlow(.init())
				return .none
				
			case .path(.element(id: _, action: .flexpoolList(.itemSelected(let itemId)))):
				state.path.append(.flexpoolDetail(.init(id: itemId)))
				return .none
				
			case .path(.element(id: _, action: .flexpoolDetail(.delegate(.finished)))):
				state.path.append(.success(.init()))
				return .none
				
			case .path(.element(id: _, action: .success(.closeButtonTapped))):
				state.path.removeAll()
				return .none
				
			case .path:
				return .none
				
			case .destination:
				return .none
			}
		}
		.ifLet(\.$destination, action: \.destination)
		.forEach(\.path, action: \.path)
	}
}
