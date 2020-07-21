//
//  TestViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 01.07.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TestViewController: UIViewController {
let disbag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let observable = Observable<String>.just("First observable")
//
//        // first example
//        let _ = observable.subscribe(onNext: { (event) in
//            print(event)
//        }, onError: { (error) in
//            print(error)
//        }, onCompleted: {
//            print("finish")
//        }) {
//            print("disposed")
//        }
//
//        // second example
//        let _ = observable.subscribe(onNext: { (event) in
//            print(event)
//        }, onError: { (error) in
//            print(error.localizedDescription)
//        }, onCompleted: {
//            print("finish")
//            }).disposed(by: disbag)
        
        // third example
//        let array = [1,2,3]
//       // var secArr: [Int] = []
//        let observable = Observable<Int>.from(array).map { $0 * 2 }
//        _ = observable.subscribe{ (e) in
//          print(e)
//            }.disposed(by: disbag)
       
        // forth example
//        let array = [1,2,3,4,5,6,7]
//        let observanle = Observable<Int>.from(array)
//        let filteredObservable = observanle.filter { $0 > 2 }
//        // подписка
//        _ = filteredObservable.subscribe{ (e) in
//            print(e)
//        }.disposed(by: disbag)
        
        //fifth example
//        let array = [1,1,1,2,3,3,4,5,5,5,6,6,7,7]
//        let observable = Observable<Int>.from(array)
//        let filteredObservable = observable.distinctUntilChanged()
//        _ = filteredObservable.subscribe({ (e) in
//            print(e)
//            }).disposed(by: disbag)
        
        
        //sixth example
//        let array = [1,1,1,2,3,3,4,5,5,5,6,6,7,7]
//        let observable = Observable<Int>.from(array)
//        let takeLastObservable = observable.takeLast(3)
//        _ = takeLastObservable.subscribe({ (e) in
//            print(e)
//            }).disposed(by: disbag)
        
        //seventh example
//        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
//        let throttleObservable = observable.throttle(1.0, scheduler: MainScheduler.instance)
//        _ = throttleObservable.subscribe({ (e) in
//            print("throttle \(e)")
//            }).disposed(by: disbag)
        
        // eight example
//        let observable = Observable<Int>.interval(1.5, scheduler: MainScheduler.instance)
//        let debounceObservable = observable.debounce(.seconds(2), scheduler: MainScheduler.instance)
//        _ = debounceObservable.subscribe({ (e) in
//            print("debounce \(e)")
//            }).disposed(by: disbag)
        
         // ten example
//        let observable = Observable<Int>.create { (observer) -> Disposable in
//            print("thread observable -> \(Thread.current)")
//            observer.onNext(1)
//            observer.onNext(2)
//            return Disposables.create()
//        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//        _ = observable.observeOn(MainScheduler.instance).subscribe({ (e) in
//              print("thread observable -> \(Thread.current)")
        //})
        // eleventh example
//        let subject = PublishSubject<Int>()
//
//        _ = subject.subscribe { (event) in print("первый подписчик \(event)")
//        }
//           subject.onNext(1)
//        _ = subject.subscribe { (event) in print("второй подписчик \(event)")
//        }
//        subject.onNext(2)
//        subject.onNext(4)
//        _ = subject.subscribe { (event) in print("третий подписчик \(event)")}
//         subject.onNext(5)
//
        // twelveth example
//        let subject = ReplaySubject<Int>.create(bufferSize: 3)
//        _ = subject.subscribe { (event) in print("первый подписчик \(event)")}
//        subject.onNext(1)
//        _ = subject.subscribe { (event) in print("второй подписчик \(event)")}
//        subject.onNext(2)
//        subject.onNext(4)
//        _ = subject.subscribe { (event) in print("третий подписчик \(event)")}
//        subject.onNext(5)
        
        // thirteen example
        let subject = BehaviorSubject<Int>(value: 0)
        _ = subject.subscribe { (event) in print("первый подписчик \(event)")}
        subject.onNext(1)
        _ = subject.subscribe { (event) in print("второй подписчик \(event)")}
        subject.onNext(2)
        subject.onNext(4)
        _ = subject.subscribe { (event) in print("третий подписчик \(event)")}
        subject.onNext(5)
        
        
        
        
        
        
        
    }
    
}
