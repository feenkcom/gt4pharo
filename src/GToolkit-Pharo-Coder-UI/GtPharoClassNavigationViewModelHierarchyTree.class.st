Class {
	#name : #GtPharoClassNavigationViewModelHierarchyTree,
	#superclass : #Object,
	#instVars : [
		'rootClass',
		'subclassTrees'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #factory }
GtPharoClassNavigationViewModelHierarchyTree class >> fromWithPharoBehaviorCoderModels: aCollectionOfWithPharoBehaviorCoderModels [
	| aRootItem theSetOfWithPharoBehaviorCoderModels theRootTrees theSubclassTrees |
	
	aRootItem := self new.
	
	theSetOfWithPharoBehaviorCoderModels := aCollectionOfWithPharoBehaviorCoderModels asSet.
	
	theRootTrees := theSetOfWithPharoBehaviorCoderModels
		reject: [ :eachWithPharoBehaviorCoderModel |
			theSetOfWithPharoBehaviorCoderModels anySatisfy: [ :eachWithPharoBehaviorSuperclassCoderModel |
				self
					isWithPharoBehaviorCoderModel: eachWithPharoBehaviorCoderModel
					inheritsFrom: eachWithPharoBehaviorSuperclassCoderModel ] ]
		thenCollect: [ :eachRootClass | eachRootClass -> (theSetOfWithPharoBehaviorCoderModels select: [ :eachClass |
				self
					isWithPharoBehaviorCoderModel: eachClass
					inheritsFrom: eachRootClass ]) ].
	
	theSubclassTrees := theRootTrees collect: [ :eachAssoc | (self fromWithPharoBehaviorCoderModels: eachAssoc value) rootClass: eachAssoc key ] as: Array.
	aRootItem subclassTrees: theSubclassTrees.
	^ aRootItem
]

{ #category : #'private - testing' }
GtPharoClassNavigationViewModelHierarchyTree class >> isWithPharoBehaviorCoderModel: aTGtWithPharoBehaviorCoderModel inheritsFrom: anOtherTGtWithPharoBehaviorCoderModel [
	^ aTGtWithPharoBehaviorCoderModel pharoBehaviorCoderModel behavior
		inheritsFrom: anOtherTGtWithPharoBehaviorCoderModel pharoBehaviorCoderModel behavior
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> at: anIndex [
	<return: #GtCoderClassesHierarchyTree>

	^ self subclassTrees at: anIndex
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> classes [
	<return: #Collection of: #Class>
	
	^ self subclassTrees collect: [ :eachTree | eachTree rootClass ]
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> first [
	<return: #GtCoderClassesHierarchyTree>

	^ self at: 1
]

{ #category : #'gt-extension' }
GtPharoClassNavigationViewModelHierarchyTree >> gtTreeFor: aView [
	<gtView>

	^ aView tree
		title: 'Classes';
		priority: 1;
		items: [ { self } ];
		children: [ :anItem | anItem subclassTrees ];
		expandUpTo: 1
]

{ #category : #testing }
GtPharoClassNavigationViewModelHierarchyTree >> hasRootClass [
	<return: #Boolean>

	^ rootClass isNotNil
]

{ #category : #initialization }
GtPharoClassNavigationViewModelHierarchyTree >> initialize [
	super initialize.
	subclassTrees := Array empty.
]

{ #category : #printing }
GtPharoClassNavigationViewModelHierarchyTree >> printOn: aStream [
	self hasRootClass
		ifTrue: [ aStream print: self rootClass ]
		ifFalse: [ aStream nextPutAll: 'Classes' ].
	
	self size isZero
		ifFalse: [ 
			aStream
				space;
				nextPut: $(;
				print: self size;
				nextPut: $) ]
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> rootClass [
	<return: #Behavior>
	^ rootClass
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> rootClass: aClass [
	rootClass := aClass
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> size [
	<return: #Number>

	^ subclassTrees size
]

{ #category : #sorting }
GtPharoClassNavigationViewModelHierarchyTree >> sort: aBlock [
	subclassTrees := subclassTrees sorted: [ :treeA :treeB | aBlock value: treeA rootClass value: treeB rootClass ].
	subclassTrees do: [ :eachTree | eachTree sort: aBlock ]
]

{ #category : #sorting }
GtPharoClassNavigationViewModelHierarchyTree >> sortByClassName [
	self sort: [ :classA :classB | classA name < classB name ]
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> subclassTrees [
	<return: #Collection of: #GtCoderClassesHierarchyTree>

	^ subclassTrees
]

{ #category : #initialization }
GtPharoClassNavigationViewModelHierarchyTree >> subclassTrees: aCollection [
	subclassTrees := aCollection
]
