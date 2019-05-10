//
//  FastParser.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

typealias FastParser = GenericParser<ImmutableCharacters, (), Character>

func string(_ string: String) -> GenericParser<ImmutableCharacters, (), String> {
    return FastParser.string(string) *> GenericParser(result: string)
}

func surrounded(by character: Character) -> GenericParser<ImmutableCharacters,(),String> {
    let delimiter = FastParser.character(character)
    return delimiter *> ({ String($0) } <^> FastParser.anyCharacter.manyTill(delimiter))
}

func lift2<Param1, Param2, Result, StreamType, UserState>(_ function: @escaping (Param1, Param2) -> Result,
                                                          _ parser1: GenericParser<StreamType, UserState, Param1>,
                                                          _ parser2: GenericParser<StreamType, UserState, Param2>) -> GenericParser<StreamType, UserState, Result> {
    return GenericParser.lift2(function, parser1: parser1, parser2: parser2)
}

func lift3<Param1, Param2, Param3, Result, StreamType, UserState>(_ function: @escaping (Param1, Param2, Param3) -> Result,
                                                                  _ parser1: GenericParser<StreamType, UserState, Param1>,
                                                                  _ parser2: GenericParser<StreamType, UserState, Param2>,
                                                                  _ parser3: GenericParser<StreamType, UserState, Param3>) -> GenericParser<StreamType, UserState, Result> {
    return GenericParser.lift3(function, parser1: parser1, parser2: parser2, parser3: parser3)
}

func lift4<Param1, Param2, Param3, Param4, Result, StreamType, UserState>(_ function: @escaping (Param1, Param2, Param3, Param4) -> Result,
                                                                          _ parser1: GenericParser<StreamType, UserState, Param1>,
                                                                          _ parser2: GenericParser<StreamType, UserState, Param2>,
                                                                          _ parser3: GenericParser<StreamType, UserState, Param3>,
                                                                          _ parser4: GenericParser<StreamType, UserState, Param4>) -> GenericParser<StreamType, UserState, Result> {
    return GenericParser.lift4(function, parser1: parser1, parser2: parser2, parser3: parser3, parser4: parser4)
}


func lift5<Param1, Param2, Param3, Param4, Param5, Result, StreamType, UserState>(_ function: @escaping (Param1, Param2, Param3, Param4, Param5) -> Result,
                                                                                  _ parser1: GenericParser<StreamType, UserState, Param1>,
                                                                                  _ parser2: GenericParser<StreamType, UserState, Param2>,
                                                                                  _ parser3: GenericParser<StreamType, UserState, Param3>,
                                                                                  _ parser4: GenericParser<StreamType, UserState, Param4>,
                                                                                  _ parser5: GenericParser<StreamType, UserState, Param5>) -> GenericParser<StreamType, UserState, Result> {
    return GenericParser.lift5(function, parser1: parser1, parser2: parser2, parser3: parser3, parser4: parser4, parser5: parser5)
}

