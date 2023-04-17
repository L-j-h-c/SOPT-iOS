//
//  AttendanceService.swift
//  Network
//
//  Created by devxsby on 2023/04/11.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation
import Combine

import Alamofire
import Moya

public typealias DefaultAttendanceService = BaseService<AttendanceAPI>

public protocol AttendanceService {
    func fetchAttendanceSchedule() -> AnyPublisher<AttendanceScheduleEntity, Error>
    func fetchAttendanceScore() -> AnyPublisher<AttendanceScoreEntity, Error>
    func fetchAttendanceRound(lectureId: Int) -> AnyPublisher<BaseEntity<AttendanceRoundEntity>, Error>
    func postAttendance(lectureRoundId: Int, code: Int) -> AnyPublisher<BaseEntity<Int>, Error>
}

extension DefaultAttendanceService: AttendanceService {
    
    public func fetchAttendanceSchedule() -> AnyPublisher<AttendanceScheduleEntity, Error> {
        requestObjectInCombine(AttendanceAPI.score)
    }
    
    public func fetchAttendanceScore() -> AnyPublisher<AttendanceScoreEntity, Error> {
        requestObjectInCombine(AttendanceAPI.lecture)
    }
    
    public func fetchAttendanceRound(lectureId: Int) -> AnyPublisher<BaseEntity<AttendanceRoundEntity>, Error> {
        requestObjectInCombine(AttendanceAPI.lectureRound(lectureId: lectureId))
    }
    
    public func postAttendance(lectureRoundId: Int, code: Int) -> AnyPublisher<BaseEntity<Int>, Error> {
        requestObjectInCombine(AttendanceAPI.attend(lectureRoundId: lectureRoundId, code: code))
    }
}
