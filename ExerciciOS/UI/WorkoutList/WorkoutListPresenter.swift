//
//  WorkoutListPresenter.swift
//  ExerciciOS
//
//  Created by joaovitor on 15/02/22.
//

import Combine
import Foundation

protocol WorkoutListPresenterProtocol: AnyObject {
    var selectedSectionIsEmpty: Bool { get }
    
    func loadWorkout()
    func numberOfSections() -> Int
    func numberOfItensInSection(section: Int) -> Int
    func workoutModel(for indexPath: IndexPath) -> Workout
    func sectionTitleAndDescription(for indexPath: IndexPath) -> (String, NSAttributedString)
    func didSelectItem(at indexPath: IndexPath)
    func didSelectOption(option: String, of workout: Workout)
    func didRemoveFromList(_ workout: Workout)
}

class WorkoutListPresenter {
    @Published var workoutGroups: [WorkoutGroup] = []
    @Published var selectedWorkouts: [Workout] = []
    
    weak var view: WorkoutListViewProtocol?
    private var cancelBag: Set<AnyCancellable> = []
    
    init(view: WorkoutListViewProtocol) {
        self.view = view
    }
}

extension WorkoutListPresenter: WorkoutListPresenterProtocol {
    var selectedSectionIsEmpty: Bool {
        selectedWorkouts.isEmpty
    }
    
    func numberOfSections() -> Int {
        let myWorkoutsSection = 1
        return workoutGroups.count + myWorkoutsSection
    }
    
    func numberOfItensInSection(section: Int) -> Int {
        if section != 0 {
            return workoutGroups[section - 1].workout.count
        }
        return max(selectedWorkouts.count, 1)
    }
    
    func workoutModel(for indexPath: IndexPath) -> Workout {
        if indexPath.section != 0 {
            return workoutGroups[indexPath.section - 1].workout[indexPath.row]
        }
        return selectedWorkouts[indexPath.row]
    }
    
    func sectionTitleAndDescription(for indexPath: IndexPath) -> (String, NSAttributedString) {
        if indexPath.section == 0 {
            return ("Meu treino", descriptionOfSelectedWorkout())
        }
        
        return workoutGroups
            .map { ($0.category, $0.description) }
            .map { (category, description) in
                (
                    category.rawValue,
                    NSAttributedString(
                        string: description,
                        attributes: [NSAttributedString.Key.foregroundColor: Colors.for(category)]
                    )
                )
            }[indexPath.section - 1]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        if indexPath.section != 0 {
            view?.addToList(workoutModel(for: indexPath))
        } else {
            view?.removeFromList(workoutModel(for: indexPath))
        }
    }
    
    func didSelectOption(option: String, of workout: Workout) {
        // adicionar opção a model workout
        var workout = workout
        workout.uuid = UUID()
        workout.selectedOption = option
        selectedWorkouts.append(workout)
    }
    
    func didRemoveFromList(_ workout: Workout) {
        if !selectedWorkouts.isEmpty {
            selectedWorkouts.removeAll { $0 == workout }
        }
    }
    
    func loadWorkout() {
        Service.request(.workouts)
            .tryMap { (groups: [WorkoutGroup]) in
                return groups
            }
            .replaceError(with: [])
            .assign(to: &$workoutGroups) // endereço do Publisher
        listenWorkoutGroup()
    }
    
    func listenWorkoutGroup() {
        $workoutGroups
            .dropFirst()
            .map { _ in }
            .merge(with: $selectedWorkouts.map { _ in })
            .sink { [weak self] _ in
                self?.view?.reloadData()
            }
            .store(in: &cancelBag)
    
        $selectedWorkouts
            .map(\.isEmpty)
            .sink(receiveValue: view?.didChangeSelectedGroup ?? { _ in })
            .store(in: &cancelBag)
    }
}

extension WorkoutListPresenter {
    private func descriptionOfSelectedWorkout() -> NSAttributedString {
        if selectedWorkouts.isEmpty {
            return .init(string: "Nenhum exercício ainda")
        }
        
        var description = NSMutableAttributedString()
        generateDescription(for: workoutGroups.first, in: &description)
        generateDescription(for: workoutGroups.last, in: &description)
        
        return description
    }
            
    private func generateDescription(for group: WorkoutGroup?, in attributedString: inout NSMutableAttributedString) {
        if let workoutGroup = group {
            let numbeOfWorkouts = numberOfSelectedWorkouts(of: workoutGroup)
            
            if attributedString.string.count > 0 {
                attributedString.append(.init(string: " "))
            }
            
            if numbeOfWorkouts > 0 {
                attributedString.append(.colored(
                    "\(numbeOfWorkouts) \(workoutGroup.category.rawValue)",
                    color: Colors.for(workoutGroup.category))
                )
            }
        }
    }
    
    private func numberOfSelectedWorkouts(of group: WorkoutGroup) -> Int {
        selectedWorkouts.reduce(0) { partialResult, workout in
            partialResult + (group.workout.map(\.id).contains(workout.id) ? 1 : 0)
        }
    }
}
