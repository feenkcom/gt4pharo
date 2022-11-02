Extension { #name : #RBNamespace }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBNamespace >> gtCleanupChanges [
	"Remove changes that are overridden by future changes. Currently, only add/remove methods are considered."

	| changesToRemove allChanges |
	changesToRemove := OrderedCollection new.
	allChanges := self changes gtAllChanges
			select: [ :each | (each isKindOf: RBAddMethodChange) or: [ each isKindOf: RBRemoveMethodChange ] ].
	1
		to: allChanges size
		do: [ :i | 
			| change |
			change := allChanges at: i.
			((change isKindOf: RBRemoveMethodChange)
				and: [ change changeClass
						ifNil: [ true ]
						ifNotNil: [ :cls | (cls includesSelector: change selector) not ] ])
				ifTrue: [ changesToRemove add: change ]
				ifFalse: [ | j |
					j := i + 1.
					[ j <= allChanges size ]
						whileTrue: [ | other |
							other := allChanges at: j.
							(change selector = other selector
								and: [ change changeClassName = other changeClassName
										and: [ change isMeta = other isMeta ] ])
								ifTrue: [ changesToRemove add: change.
									j := allChanges size ].
							j := j + 1 ] ] ].
	(self changes gtCopyWithout: changesToRemove)
		ifNotNil: [ :obj | changes := obj ]
]
