# Sample-CollectionView-with-CompositionType


## Scheme

* Xcode9.2
* Swift4

## Abstracts

* Composition type
  * `UICollectionViewDataSource`, which is easy to exchage with other DataSources.
  * `UIImagePickerController`, which its object is composited with a closure instead of using delegate. 
  * `UICollectionViewFlowLayout`
  
* Customizing the Transition Animation
  * `UIViewControllerAnimatedTransitioning`
  * `UIViewControllerTransitioningDelegate`

* UserDefaults Confirming to Proeocol
  * To improve testabilities (cf. `Persistable`)
  * To provide `DataStore` as intefaces with Repositories

* Managing common features and functions by Protocols
  * `ViewModelItem`
  * `DataSourcing`
  * `CellIdentifiable`
  
* Persistence with Serizlized Data
  * Inheritance from `NSCoding`
  * `NSKeyedArchiver` and `NSKeyedUnarchiver`
