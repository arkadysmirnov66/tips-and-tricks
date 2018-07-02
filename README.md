# tips-and-tricks
Fun or often used pieces of code :)

## Multithreading
- AsyncOperation - implemntation of async operation based on NSOperation
- BaseOperation - it's child of AsyncOperation with Result 
- SynchronizedArray - thread-safe array

## Extentions
- QualityOfService - mapping to DispatchQoS enum
- DispatchQueue - async method for ((T) -> Void) complition closures

## Structures
- Metatype - hashable implementation of Self.type
- Container - fabric based on Metatype and closures
- Result - simple structure for any kind of requests or workers
