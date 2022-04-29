@testable import NablaUtils
import XCTest

class ResolverTests: XCTestCase {
    func testRegisterAndResolvePrimitiveValue() {
        // GIVEN
        let sut = Resolver()
        
        // WHEN
        sut.register(type: Double.self, 42)
        let resolved = sut.resolve(Double.self)
        
        // THEN
        XCTAssertEqual(resolved, 42)
    }
    
    func testRegisterAndResolveClassInstance() {
        // GIVEN
        let sut = Resolver()
        let instance = SomeClass(value: 42)
        
        // WHEN
        sut.register(type: SomeClass.self, instance)
        let resolved = sut.resolve(SomeClass.self)
        
        // THEN
        XCTAssertEqual(resolved.value, 42)
    }
    
    func testRegisterAndResolveMultipleClassInstances() {
        // GIVEN
        let sut = Resolver()
        let instance1 = SomeClass(value: 42)
        let instance2 = SomeClass(value: 777)
        
        // WHEN
        sut.register(type: SomeClass.self, instance1)
        sut.register(type: SomeClass.self, instance2)
        let resolved = sut.resolve(SomeClass.self)
        
        // THEN
        XCTAssertEqual(resolved.value, 777)
    }
    
    func testRegsiterClosureAndResolveMultipleInstances() {
        // GIVEN
        let sut = Resolver()
        var counter = 0
        
        // WHEN
        sut.register(type: SomeClass.self) { () -> SomeClass in
            counter += 1
            return SomeClass(value: counter)
        }
        let resolved1 = sut.resolve(SomeClass.self)
        let resolved2 = sut.resolve(SomeClass.self)
        
        // THEN
        XCTAssertEqual(resolved1.value, 1)
        XCTAssertEqual(resolved2.value, 1)
    }
    
    func testRegsiterClosureAndResolveMultipleInstancesSeparately() {
        // GIVEN
        let sut = Resolver()
        var counter = 0
        
        // WHEN
        sut.register(type: SomeClass.self) { () -> SomeClass in
            counter += 1
            return SomeClass(value: counter)
        }
        var resolved1: SomeClass? = sut.resolve(SomeClass.self)
        let resolvedValue1 = resolved1?.value
        resolved1 = nil
        let resolved2 = sut.resolve(SomeClass.self)
        
        // THEN
        XCTAssertEqual(resolvedValue1, 1)
        XCTAssertEqual(resolved2.value, 1)
    }
    
    func testRegisterSubclassAndResolveInstance() {
        // GIVEN
        let sut = Resolver()
        let instance = SomeSubclass()
        
        // WHEN
        sut.register(type: SomeClass.self, instance)
        let resolved = sut.resolve(SomeClass.self)
        
        // THEN
        XCTAssertEqual(resolved.value, 42)
    }
    
    func testRegisterSubclassAndResolveInterface() {
        // GIVEN
        let sut = Resolver()
        let instance = SomeSubclass()
        
        // WHEN
        sut.register(type: SomeInterface.self, instance)
        let resolved = sut.resolve(SomeInterface.self)
        
        // THEN
        XCTAssertEqual(resolved.value, 42)
    }
}

private protocol SomeInterface {
    var value: Int { get }
}

private class SomeClass: SomeInterface {
    let value: Int
    
    init(value: Int) {
        self.value = value
    }
}

private class SomeSubclass: SomeClass {
    init() {
        super.init(value: 42)
    }
}
