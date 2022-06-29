Extension { #name : #BlElement }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
BlElement >> gtConstraintsAdvice: aGtAdvice [
	<gtAdvice: 10>
	| hFitContents vFitContents |
	self
		withAllParentsDo: [ :each | 
			((each isKindOf: BlInfiniteElement) or: [ each isKindOf: BlScrollableElement ])
				ifTrue: [ hFitContents := vFitContents := nil ].
			each
				constraintsDo: [ :c | 
					(c horizontal isKindOf: BlLayoutCommonConstraintsAxis)
						ifTrue: [ c horizontal resizer
								ifNotNil: [ :r | 
									(r isKindOf: BlLayoutMatchParentResizer)
										ifTrue: [ hFitContents notNil
												ifTrue: [ ^ (GtElementConstraintsAdvice on: aGtAdvice)
														vertical: false;
														fitContentsElement: hFitContents;
														matchParentElement: each ] ]
										ifFalse: [ hFitContents := ((r isKindOf: BlLayoutFitContentResizer)
													or: [ r isKindOf: BlLayoutFitContentLimitedOffsetResizer ])
													ifTrue: [ each ]
													ifFalse: [ nil ] ] ] ].
					(c vertical isKindOf: BlLayoutCommonConstraintsAxis)
						ifTrue: [ c vertical resizer
								ifNotNil: [ :r | 
									(r isKindOf: BlLayoutMatchParentResizer)
										ifTrue: [ vFitContents notNil
												ifTrue: [ ^ (GtElementConstraintsAdvice on: aGtAdvice)
														vertical: true;
														fitContentsElement: vFitContents;
														matchParentElement: each ] ]
										ifFalse: [ vFitContents := ((r isKindOf: BlLayoutFitContentResizer)
													or: [ r isKindOf: BlLayoutFitContentLimitedOffsetResizer ])
													ifTrue: [ each ]
													ifFalse: [ nil ] ] ] ] ] ].
	^ aGtAdvice none
]
