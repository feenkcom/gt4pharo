Class {
	#name : #GtPushUpMethodRefactoring,
	#superclass : #RBPullUpMethodRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #preconditions }
GtPushUpMethodRefactoring >> checkSuperSendsFromSiblings [
	| selectorsWithSuperImplementations definer |
	targetSuperclass subclasses size <= 1 ifTrue: [ ^ self ].
	selectorsWithSuperImplementations := selectors
			select: [ :each | class superclass definesMethod: each ].
	selectorsWithSuperImplementations isEmpty ifTrue: [ ^ self ].
	selectorsWithSuperImplementations
		do: [ :impl | 
			self model
				allReferencesTo: impl
				do: [ :method | 
					((method methodClass includesClass: class) not
						and: [ (method methodClass includesClass: class superclass)
								and: [ class superclass
										includesClass: (definer := method methodClass superclass whoDefinesMethod: impl) ] ])
						ifTrue: [ (method ast superMessages includes: impl)
								ifTrue: [ self
										refactoringError: ('Cannot push up <1s> since it would override the method defined in <2p>'
												expandMacrosWith: impl
												with: definer) ] ] ] ]
]
