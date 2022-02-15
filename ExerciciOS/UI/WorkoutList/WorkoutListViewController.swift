//
//  WorkoutListViewController.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import Foundation
import UIKit

protocol WorkoutListViewProtocol: AnyObject {
    func reloadData()
    func addToList(_ workout: Workout)
    func removeFromList(_ workout: Workout)
    func didChangeSelectedGroup(isEmpty: Bool)
}

class WorkoutListViewController: BaseViewController<WorkoutListView> {
    lazy var presenter: WorkoutListPresenterProtocol = WorkoutListPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.loadWorkout()
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: WorkoutCell.identifier)
        customView.collectionView.register(WorkoutCellSectionHeader.self, forSupplementaryViewOfKind: WorkoutCellSectionHeader.identifier, withReuseIdentifier: WorkoutCellSectionHeader.identifier)
        customView.collectionView.register(PlaceholderCell.self, forCellWithReuseIdentifier: PlaceholderCell.identifier)
    }
}

// MARK: Delegates
extension WorkoutListViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections()
    }
    
    // configurando os cabeçalhos
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == WorkoutCellSectionHeader.identifier {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkoutCellSectionHeader.identifier, for: indexPath) as? WorkoutCellSectionHeader {
                let (title, description) = presenter.sectionTitleAndDescription(for: indexPath)
                header.configure(title: title, description: description)
                return header
            }
        }
        return .init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: DataSource
extension WorkoutListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItensInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0, presenter.selectedSectionIsEmpty {
            if let placeholderCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceholderCell.identifier, for: indexPath) as? PlaceholderCell {
                placeholderCell.configure()
                return placeholderCell
            }
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCell.identifier, for: indexPath) as? WorkoutCell {
            cell.configure(model: presenter.workoutModel(for: indexPath))
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension WorkoutListViewController: WorkoutListViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.customView.collectionView.reloadData()
        }
    }
    
    func removeFromList(_ workout: Workout) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let destructiveAction = UIAlertAction(title: "Remover", style: .destructive) { [weak self] _ in
            self?.presenter.didRemoveFromList(workout)
        }
        
        alert.addAction(destructiveAction)
        
        present(alert, animated: true)
    }
    
    func didChangeSelectedGroup(isEmpty: Bool) {
        let layout: UICollectionViewCompositionalLayout = isEmpty ? .placeholder() : .default()
        
        customView.collectionView.setCollectionViewLayout(layout, animated: false) { _ in
            DispatchQueue.main.async {
                self.customView.collectionView.reloadSections(.init(arrayLiteral: 0))
            }
        }
    }
    
    func addToList(_ workout: Workout) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        workout.options?
            .map { option in
                UIAlertAction(title: option, style: .default) { [weak self] _ in
                    self?.presenter.didSelectOption(option: option, of: workout)
                }
            }
            .forEach(alert.addAction)
        
        present(alert, animated: true)
    }
}
