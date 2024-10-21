Class {
	#name : #GtSearchMethodCoderFilterContext,
	#superclass : #GtSearchFilterContext,
	#traits : 'TGtOptions',
	#classTraits : 'TGtOptions classTrait',
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> behavior [
	^ self optionAt: #behavior ifAbsent: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> behavior: aBehavior [
	self optionAt: #behavior put: aBehavior
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> behaviorDo: aBlock [
	^ self
		optionAt: #behavior
		ifPresent: aBlock
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> compiledMethodDo: aBlock [
	^ self
		behaviorDo: [ :aClass | 
			self
				selectorDo: [ :aSelector | 
					aClass methodDict
						at: aSelector
						ifPresent: [ :aMethod | aBlock value: aMethod ]
						ifAbsent: [ nil ] ] ]
]

{ #category : #testing }
GtSearchMethodCoderFilterContext >> hasBehavior [
	^ self hasOptionAt: #behavior
]

{ #category : #testing }
GtSearchMethodCoderFilterContext >> hasObject [
	^ self hasOptionAt: #object
]

{ #category : #testing }
GtSearchMethodCoderFilterContext >> hasSelector [
	^ self hasOptionAt: #selector
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> nodeInPosition: anAstNode [
	self optionAt: #nodeInPosition put: anAstNode
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> nodeInPositionDo: aBlock [
	^ self nodeInPositionDo: aBlock ifNone: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> nodeInPositionDo: aPresentBlock ifNone: anAbsentBlock [
	^ self
		optionAt: #nodeInPosition
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> object [
	^ self optionAt: #object ifAbsent: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> object: anObject [
	self optionAt: #object put: anObject
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> scopedMethodsItems [
	<return: #Collection of: #GtSearchScopedMethodsScope>
	| aCollection |
	aCollection := Array
		streamContents: [ :aStream | 
			GtSearchScopedMethodsScope
				allSubclassesDo: [ :aClass | 
					aClass isAbstract
						ifFalse: [ aClass itemInstancesForFilterContext: self into: aStream ] ] ].
	aCollection sort: [ :a :b | a order < b order ].
	^ aCollection						
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectedScope: aScope [
	self optionAt: #selectedScope put: aScope
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectedScopeDo: aBlock [
	^ self selectedScopeDo: aBlock ifNone: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectedScopeDo: aPresentBlock ifNone: anAbsentBlock [
	^ self
		optionAt: #selectedScope
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selector [
	^ self optionAt: #selector ifAbsent: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selector: aMethodSelector [
	self optionAt: #selector put: aMethodSelector
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectorDo: aBlock [
	^ self
		optionAt: #selector
		ifPresent: aBlock
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectorInPosition: aSelector [
	self optionAt: #selectorInPosition put: aSelector
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectorInPositionDo: aBlock [
	^ self selectorInPositionDo: aBlock ifNone: [ nil ]
]

{ #category : #accessing }
GtSearchMethodCoderFilterContext >> selectorInPositionDo: aPresentBlock ifNone: anAbsentBlock [
	^ self
		optionAt: #selectorInPosition
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]
