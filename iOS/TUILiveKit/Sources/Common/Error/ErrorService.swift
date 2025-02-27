//
//  VRErrorService.swift
//  TUILiveKit
//
//  Created by aby on 2024/3/11.
//

import Foundation
import RTCRoomEngine
import Combine
import ImSDK_Plus

protocol LocalizedError: Error {
    var description: String { get }
}

typealias InternalError = ErrorService.OperateError

class ErrorService {
    
    deinit {
        debugPrint("deinit \(type(of: self))")
    }
    
    /// OperateError
    /// - property:
    ///     - error: TUIError, RoomEngine throw.
    ///     - message: RoomEngine throw
    ///     - localizedMessage: covert to localized string.
    ///     - actions: if you want to dispatch actions after receive error, append action to this property.
    ///     store will filter error action and dispath others.
    struct OperateError: Error {
        let error: LocalizedError
        let message: String
        var actions: [Action] = []
        var localizedMessage: String {
            error.description
        }
        
        init(error: LocalizedError, message: String) {
            self.error = error
            self.message = message
        }
    }
}

extension TUIBattleCode: LocalizedError {
    var description: String {
        switch self {
            case .unknown:
                return .localized("live.error.failed")
            case .success:
                return .localized("live.error.success")
            case .battlingOtherRoom:
                return .localized("live.battle.error.conflict")
            default:
                return .localized("live.battle.error.other")
        }
    }
}

enum TIMError: Int, Error {
    case success = 0
    case failed = -1
    case invalidUserId = 7_002
}

extension TIMError: LocalizedError {
    var description: String {
        switch self {
            case .success:
                return .localized("live.error.success")
            case .failed:
                return .localized("live.error.failed")
            case .invalidUserId:
                return .localized("live.error.invalid.userId")
        }
    }
}

extension TUIConnectionCode: LocalizedError {
    var description: String {
        switch self {
        case .success:
            return .localized("live.error.success")
        case .roomNotExist:
            return .localized("live.error.connection.notexit")
        case .connecting:
            return .localized("live.error.connection.connecting")
        case .connectingOtherRoom:
            return .localized("live.error.connection.connectingOtherRoom")
        case .full:
            return .localized("live.error.connection.full")
        case .retry:
            return .localized("live.error.connection.retry")
        default:
            return .localized("live.error.failed")
        }
    }
}

extension TUIError: LocalizedError {
    var description: String {
        switch self {
            case .success:
                return .localized("live.error.success")
            case .failed:
                return .localized("live.error.failed")
            case .freqLimit:
                return .localized("live.error.freqLimit")
            case .repeatOperation:
                return .localized("live.error.repeat.operation")
            case .sdkAppIDNotFound:
                return .localized("live.error.sdkAppId.notFound")
            case .invalidParameter:
                return .localized("live.error.invalidParameter")
            case .sdkNotInitialized:
                return .localized("live.error.sdkNotInitialized")
            case .permissionDenied:
                return .localized("live.error.permissionDenied")
            case .requirePayment:
                return .localized("live.error.requirePayment")
            case .cameraStartFail:
                return .localized("live.error.cameraStartFail")
            case .cameraNotAuthorized:
                return .localized("live.error.cameraNotAuthorized")
            case .cameraOccupied:
                return .localized("live.error.cameraOccupied")
            case .cameraDeviceEmpty:
                return .localized("live.error.cameraDeviceEmpty")
            case .microphoneStartFail:
                return .localized("live.error.microphoneStartFail")
            case .microphoneNotAuthorized:
                return .localized("live.error.microphoneNotAuthorized")
            case .microphoneOccupied:
                return .localized("live.error.microphoneOccupied")
            case .microphoneDeviceEmpty:
                return .localized("live.error.microphoneDeviceEmpty")
            case .getScreenSharingTargetFailed:
                return .localized("live.error.getScreenSharingTargetFailed")
            case .startScreenSharingFailed:
                return .localized("live.error.startScreenSharingFailed")
            case .roomIdNotExist:
                return .localized("live.error.roomId.notExist")
            case .operationInvalidBeforeEnterRoom:
                return .localized("live.error.operation.invalid.beforeEnterRoom")
            case .exitNotSupportedForRoomOwner:
                return .localized("live.error.exitNotSupported.forRoomOwner")
            case .operationNotSupportedInCurrentRoomType:
                return .localized("live.error.operation.notSupported.inCurrentSpeechMode")
            case .roomIdInvalid:
                return .localized("live.error.roomId.invalid")
            case .roomIdOccupied:
                return .localized("live.error.roomId.occupied")
            case .roomNameInvalid:
                return .localized("live.error.roomName.invalid")
            case .alreadyInOtherRoom:
                return .localized("live.error.already.in.OtherRoom")
            case .userNotExist:
                return .localized("live.error.userNotExist")
            case .userNotEntered:
                return .localized("live.error.userNotEntered")
            case .userNeedOwnerPermission:
                return .localized("live.error.user.need.OwnerPermission")
            case .userNeedAdminPermission:
                return .localized("live.error.user.need.AdminPermission")
            case .requestNoPermission:
                return .localized("live.error.request.noPermission")
            case .requestIdInvalid:
                return .localized("live.error.requestId.invalid")
            case .requestIdRepeat:
                return .localized("live.error.repeat.requestId")
            case .requestIdConflict:
                return .localized("live.error.conflict.requestId")
            case .maxSeatCountLimit:
                return .localized("live.error.max.seat.count.limit")
            case .alreadyInSeat:
                return .localized("live.error.already.in.seat")
            case .seatOccupied:
                return .localized("live.error.seat.occupied")
            case .seatLocked:
                return .localized("live.error.seat.locked")
            case .seatIndexNotExist:
                return .localized("live.error.seat.index.not.exist")
            case .userNotInSeat:
                return .localized("live.error.user.not.in.seat")
            case .allSeatOccupied:
                return .localized("live.error.all.seat.occupied")
            case .seatNotSupportLinkMic:
                return .localized("live.error.seat.not.support.link.mic")
            case .openMicrophoneNeedSeatUnlock:
                return .localized("live.error.open.microphone.need.seat.unlock")
            case .openMicrophoneNeedPermissionFromAdmin:
                return .localized("live.error.open.microphone.need.permission.from.admin")
            case .openCameraNeedSeatUnlock:
                return .localized("live.error.open.camera.need.seat.unlock")
            case .openCameraNeedPermissionFromAdmin:
                return .localized("live.error.open.camera.need.permission.from.admin")
            case .openScreenShareNeedSeatUnlock:
                return .localized("live.error.open.screen.share.need.seat.unlock")
            case .openScreenShareNeedPermissionFromAdmin:
                return .localized("live.error.open.screen.share.need.permission.from.admin")
            case .sendMessageDisabledForAll:
                return .localized("live.error.send.message.disabled.for.all")
            case .sendMessageDisabledForCurrent:
                return .localized("live.error.send.message.disabled.for.current")
            case .roomConnectedInOther:
                return .localized("live.error.linkMicDisable.connecting")
            @unknown default:
                return .localized("live.error.failed")
        }
    }
}
