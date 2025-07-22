Extension { #name : #RBLiteralValueNode }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBLiteralValueNode >> gtIsBaselineName [
	self value isString ifFalse: [ ^ false ].
	self class environment
		at: ('BaselineOf' , self value) asSymbol
		ifAbsent: [ ^ false ].
	self withAllParents first
		nodesDo: [ :each | 
			(each value isString and: [ each value = self value ])
				ifTrue: [ each parent isMessage
						ifTrue: [ | index |
							index := each parent arguments identityIndexOf: each.
							index > 0
								ifTrue: [ (each parent selectorParts at: index) = 'package:' ifTrue: [ ^ false ] ] ] ] ].
	^ true
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBLiteralValueNode >> gtIsBaselinePackageName [
	self value isString ifFalse: [ ^ false ].
	self packageOrganizer packageNamed: self value ifAbsent: [ ^ false ].
	self withAllParents first
		nodesDo: [ :each | 
			(each isLiteralNode
				and: [ each value isString and: [ each value = self value ] ])
				ifTrue: [ each parent isMessage
						ifTrue: [ | index |
							index := each parent arguments identityIndexOf: each.
							index > 0
								ifTrue: [ (each parent selectorParts at: index) = 'baseline:' ifTrue: [ ^ false ] ] ] ] ].
	^ true
]
