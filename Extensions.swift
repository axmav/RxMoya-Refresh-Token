//
//  Extensions.swift
//  raketa
//
//  Created by Alexandr Mavrichev on 30.10.17.
//

import Foundation
import RxSwift
import Moya
import XCGLogger

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    public func retryWithAuthIfNeeded() -> Single<ElementType> {
        return retryWhen { e in
            Observable.zip(e, Observable.range(start: 1, count: 3),
                           resultSelector: { $1 })
                .flatMap { i -> PrimitiveSequence<SingleTrait, Access> in
                    return DataAPIProvider.rx
                        .request(.refreshToken(token: "YOUR REFRESH TOKEN"))
                        .filterSuccessfulStatusCodes()
                        .mapObject(Access.self)
                        .catchError { error in
                            if case MoyaError.statusCode(let response) = error  {
                                if response.statusCode == 401 {
                                    // Logout logic
                                }
                            }
                            return Single.error(error)
                        }.flatMap({ access -> PrimitiveSequence<SingleTrait, Access> in
                            XCGLogger.default.debug(access.accessToken)
                            XCGLogger.default.debug(access.refreshToken)
                            // Refresh your access and reresh token here
                            return Single.just(access)
                        })
            }
        }
    }
}

