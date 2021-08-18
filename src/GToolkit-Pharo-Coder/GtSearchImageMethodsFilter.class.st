Class {
	#name : 'GtSearchImageMethodsFilter',
	#superclass : 'GtSearchMethodsFilter',
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : 'comparing' }
GtSearchImageMethodsFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ true
]

{ #category : 'enumerating' }
GtSearchImageMethodsFilter >> classesDo: aBlock [
	GtPharoSystemTraverser default allClassesAndTraitsDo: aBlock
]

{ #category : 'accessing' }
GtSearchImageMethodsFilter >> defaultFilterScope [
	^ self
]

{ #category : 'testing' }
GtSearchImageMethodsFilter >> includesMethod: aCompiledMethod [
	self methodsDo: [ :anotherMethod | 
		anotherMethod = aCompiledMethod ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'enumerating' }
GtSearchImageMethodsFilter >> itemsDo: aBlock [
	^ self methodsDo: aBlock
]

{ #category : 'enumerating' }
GtSearchImageMethodsFilter >> methodsDo: aBlock [
	self classesDo: [ :aClass |
		aClass instanceSide methods do: aBlock.
		aClass classSide methods do: aBlock. ]
]
