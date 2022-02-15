//
//  Workout.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import Foundation

// MARK: - WorkoutGroup
struct WorkoutGroup: Codable {
    let category: WorkoutCategory
    let description: String
    let workout: [Workout]

    enum CodingKeys: String, CodingKey {
        case category = "categoria"
        case description = "descricao"
        case workout = "exercicios"
    }
}

enum WorkoutCategory: String, Codable {
    case bodybuilding = "Musculação"
    case aerobic = "Aeróbicos"
}

// MARK: - Workout
struct Workout: Codable, Hashable, Equatable {
    let id: Int
    var uuid: UUID?
    let name: String
    let image: String
    let options: [String]?
    var selectedOption: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case image = "imagem"
        case options = "opcoes"
        case selectedOption
        case uuid
    }
}

extension Workout {
    static func mock() -> Workout {
        .init(id: 0, uuid: UUID(), name: "Halteres", image: " ", options: [
            "Iniciante (9 repetições)",
            "Intermediário (12 repetições)",
            "Avançado (15 repetições)"
        ])
    }
}

// MARK: antes do Swift 4.0 para struct ->
//extension Workout: Equatable {
//    static func ==(lhs: Workout, rhs: Workout) -> Bool {
//        return
//            lhs.id == rhs.id &&
//            lhs.name == rhs.name &&
//            lhs.image == rhs.image &&
//            lhs.options == rhs.options &&
//            lhs.selectedOption == rhs.selectedOption
//    }
//}
