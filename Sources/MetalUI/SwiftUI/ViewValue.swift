//
//  ViewValue.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 22.01.26.
//

public enum ViewValue<BaseType: Equatable> {
    case fixed(_ value: BaseType)
    case dynamic(_ value: BaseType)
}
