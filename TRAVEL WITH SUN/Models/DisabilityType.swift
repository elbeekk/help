//
//  DisabilityType.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import Foundation

enum DisabilityType: String, CaseIterable, Identifiable {
    case mobility = "Mobility Impairment"
    case visual = "Visual Impairment"
    case hearing = "Hearing Impairment"
    case cognitive = "Cognitive Disability"
    case multiple = "Multiple Disabilities"
    case other = "Other"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .mobility: return "figure.walk"
        case .visual: return "eye.slash"
        case .hearing: return "ear.badge.waveform"
        case .cognitive: return "brain.head.profile"
        case .multiple: return "person.2"
        case .other: return "ellipsis.circle"
        }
    }
}
