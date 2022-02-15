//
//  UICollectionViewCompositionalLayout+Layouts.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

extension UICollectionViewCompositionalLayout {
    static func `default`() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0:
                return .carouselSection()
            default:
                return .defaultSection()
            }
        }
    }
    
    static func placeholder() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0:
                return .emptySection()
            default:
                return .defaultSection()
            }
        }
    }
}

// NSCollectionLayoutSection: Um container que combina um conjunto de grupos em agrupamentos visuais distintos.
extension NSCollectionLayoutSection {
    
    static func carouselSection() -> NSCollectionLayoutSection {
        // .fractionalWidth - proporcinal a largura da tela
        // .fractionalWidth(0.5) - metade da tela
        // .fractionalWidth(1) - largura completa da tela
        // .estimated - é um tamanho estimado. O tamanho final será determinado quando o conteúdo for renderizado
        // .absolute - cria uma dimensão com um valor absoluto (inalterável)
        
        // definindo o item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(calculateCellSize().width), heightDimension: .absolute(calculateCellSize().height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
        // definindo o grupo
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(15)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        // definindo a seção
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 15, leading: 0, bottom: 15, trailing: 0)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                elementKind: WorkoutCellSectionHeader.identifier,
                alignment: .top,
                absoluteOffset: .init(x: 15, y: 0)
            )
        ]
        
        return section
    }
    
    static func defaultSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(calculateCellSize().width), heightDimension: .absolute(calculateCellSize().height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(15)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                elementKind: WorkoutCellSectionHeader.identifier,
                alignment: .top,
                absoluteOffset: .init(x: 15, y: 0)
            )
        ]
        
        return section
    }
    
    static func emptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(calculateCellSize().height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(15)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                elementKind: WorkoutCellSectionHeader.identifier,
                alignment: .top,
                absoluteOffset: .init(x: 15, y: 0)
            )
        ]
        
        return section
    }
}

// função visível somente neste arquivo
fileprivate func calculateCellSize(margin: CGFloat = 15, spacing: CGFloat = 15) -> CGSize {
    let visibleCells: CGFloat = 2
    let fullWidth = UIScreen.main.bounds.width
    let cellSize = fullWidth - (margin * 2) - spacing
    let cellSizeForTwoCells = cellSize / visibleCells
    
    return CGSize(width: cellSizeForTwoCells, height: cellSizeForTwoCells)
}
