Extension { #name : #BlElement }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
BlElement >> gtCheckChildMatchParentInParentFitContentConstraints: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 10;
		description: [ :each | (each printString , ' matches parent that fits content') asRopedText ];
		compute: [ | elements |
			elements := OrderedCollection new.
			self withAllChildrenDepthFirstDo: [ :each |
				each gtHasMatchParentChildrenInParentWithFitContent
					ifTrue: [ elements add: each ] ].
			elements ];
		action: [ :each | GtPhlowObjectAdviceAction object: each ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
BlElement >> gtCheckLayoutConstraints: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 10;
		description: [ :each | (each printString , ' has basic layout with fit contents') asRopedText ];
		compute: [ | elements |
			elements := OrderedCollection new.
			self
				withAllParentsDo: [ :each | each gtHasBasicLayoutWithFitContents ifTrue: [ elements add: each ] ].
			self
				allChildrenDepthFirstDo: [ :each | each gtHasBasicLayoutWithFitContents ifTrue: [ elements add: each ] ].
			elements ];
		action: [ :each | GtPhlowObjectAdviceAction object: each ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
BlElement >> gtHasBasicLayoutWithFitContents [
	self children isEmpty ifTrue: [ ^ false ].
	(self layout isKindOf: BlBasicLayout) ifFalse: [ ^ false ].
	(self constraints isKindOf: BlLayoutCommonConstraints) ifFalse: [ ^ false ].
	^ #(horizontal vertical)
		anySatisfy: [ :each | 
			| constraint |
			constraint := self constraints perform: each.
			(constraint isKindOf: BlLayoutCommonConstraintsAxis)
				and: [ (constraint resizer isKindOf: BlLayoutFitContentResizer)
						or: [ constraint resizer isKindOf: BlLayoutFitContentLimitedResizer ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
BlElement >> gtHasMatchParentChildrenInParentWithFitContent [
	self hasParent ifFalse: [ ^ false ].

	^ #(horizontal vertical)
		anySatisfy: [ :each | 
			| myConstraint parentConstraint |
			myConstraint := self constraints perform: each.
			parentConstraint := self parent constraints perform: each.
			myConstraint resizer isMatchParent
				and: [ parentConstraint resizer isFitContent ] ]
]
